require_relative "version"

require_relative 'ui'
require_relative 'logic'
require_relative 'helper'
require_relative 'player'
require 'yaml'

class MasterMind
  VERSION = 1.0
  extend Helper
  
  def self.home_screen
    puts UI::WELCOME_MESSAGE
    print UI::OPTIONS_MESSAGE
    
    user_choice
  end
  
  def self.user_choice
    option_chosen = false
    
    while !option_chosen
      option_chosen = true                              # assume user selects valid option so as to quit loop
      
      input = gets.chomp.downcase
      case input
      when "p", "play" then play_game
      when "r", "read"
        puts UI::HELP_MESSAGE
        print UI::OPTIONS_MESSAGE
        option_chosen = false
      when "q", "quit" then exit(0)
      else                                               # user selects an invalid option
        print UI::INVALID_MESSAGE
        option_chosen = false
      end  
    end
  end
  
  def self.ask_level
    print UI::LEVEL_MESSAGE
    option_chosen = false
    
    while !option_chosen
      option_chosen = true                              # assume user selects valid option so as to quit loop
      
      input = gets.chomp.downcase
      case input
      when "b", "beginner" then return 0
      when "i", "intermediate" then return 1
      when "a", "advanced" then return 2
      else                                               # user selects an invalid option
        print UI::INVALID_MESSAGE
        option_chosen = false
      end  
    end
  end
  
  def self.get_name_store(sequence, guesses, time)  
    print UI::NAME_MESSAGE
    name_entered = false
    
    while !name_entered
      name_entered = true                              # assume user enters name
      
      name = gets.chomp.downcase
      case name
      when ""                                               # user enters no name
        print UI::INVALID_MESSAGE
        name_entered = false
      end  
    end
    current_player = Player.new(name, sequence, time, guesses)
    File.open(UI::DB_STORE, 'a'){|file| file.write(YAML.dump(current_player))}
    return name
  end
    
  def self.play_game
    game_logic = GameLogic.new(ask_level)
    sequence = game_logic.generate_sequence
    print UI::GENERATE_MESSAGE % UI::COLOR_STRINGS[game_logic.level]
    start_time = Time.now
    guesses = 0
    allowed = ['c', 'q', 'quit', 'cheat']
    
    catch :complete do
      while guesses < 12
        input = gets.chomp.downcase
          
        if input.length < game_logic.length && !(allowed.include?(input))
          puts UI::INPUT_SHORT_MESSAGE
          next
          
        elsif input.length > game_logic.length && !(allowed.include?(input)) 
          puts UI::INPUT_LONG_MESSAGE
          next 
        end
        
        case input
        when "q", "quit" then exit(0)
        when "c", "cheat" then print UI::SEQUENCE_MESSAGE % sequence.join.upcase
        else
          guesses += 1
          if input == sequence.join
            time_elapsed = (Time.now - start_time).to_i
            name = get_name_store(sequence, guesses, time_elapsed)
            
            top_ten_list = YAML.load_stream(File.open(UI::DB_STORE)).sort{|player1, player2|
              by_guess = player2.guesses <=> player1.guesses
              by_guess == 0 ? player1.time <=> player2.time : by_guess
            }[0..10]  if File.file?(UI::DB_STORE)
            
            puts UI::CONGRATS_MESSAGE % [name, sequence.join.upcase, guesses, guesses > 1 ? "guesses" : "guess", time_convert(time_elapsed)] 
            puts UI::TOP_TEN
            puts top_ten_list
            print UI::OPTIONS_MESSAGE
            user_choice
            throw :complete
          end
          
          GameLogic.check_input(sequence, input, guesses)     
        end
      end
    end
  end
end

MasterMind.home_screen

