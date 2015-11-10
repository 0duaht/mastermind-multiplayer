require 'ui'
require 'logic'
require 'timehelper'
require 'player'
require 'yaml'
require 'gameplay'

class MasterMind
  VERSION = 1.0
  extend TimeHelper
  
  def self.start
    puts UI::WELCOME_MESSAGE
    print UI::OPTIONS_MESSAGE + UI::INPUT_PROMPT
    
    user_choice
  end
  
  def self.user_choice
    option_chosen = false
    
    while !option_chosen
      option_chosen = true                              # assume user selects valid option so as to quit loop
      
      input = gets.chomp.downcase
      option_chosen = validate_input(input)
    end
  end
  
  def self.validate_input(input)
    case input
      when "p", "play" then play_game
      when "r", "read"
        puts UI::HELP_MESSAGE
        print UI::OPTIONS_MESSAGE
        return false                                     # continue loop after displaying help message
      when "q", "quit" then exit(0)
      else                                               # user selects an invalid option
        print UI::INVALID_MESSAGE
        return false
    end
    return true
  end
  
  def self.ask_level
    print UI::LEVEL_MESSAGE
    option_chosen = false
    
    while !option_chosen
      option_chosen = true                              # assume user selects valid option so as to quit loop
      
      input = gets.chomp.downcase
      case input                                        
      when "b", "beginner" then return GameLogic::BEGINNER
      when "i", "intermediate" then return GameLogic::INTERMEDIATE
      when "a", "advanced" then return GameLogic::ADVANCED
      else                                               # user selects an invalid option
        print UI::INVALID_MESSAGE
        option_chosen = false
      end  
    end
  end
  
  def self.get_name_store(sequence, guesses, time)      #get player name and store details to file  
    print UI::NAME_MESSAGE
    name_entered = false
    name = ""
    
    while name.eql?("")
      name = gets.chomp.downcase
      print UI::INVALID_MESSAGE if name.eql?("")  
    end
    
    current_player = Player.new(name, sequence, time, guesses)  # create new player object
    File.open(UI::DB_STORE, 'a'){|file| file.write(YAML.dump(current_player))} 
    return name
  end
    
  def self.play_game
    game_logic = GameLogic.new(ask_level)
    sequence = game_logic.generate_sequence
    print UI::GENERATE_MESSAGE % UI::COLOR_STRINGS[game_logic.level]
    start_time = Time.now
    guesses = 0
    allowed = ['c', 'h', 'q', 'cheat', 'history', 'quit']
    history = []
    
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
        when "h", "history"
          if history.empty?
            puts "No history yet. Enter a guess"  + UI::INPUT_PROMPT
            next
          else
            puts history 
          end
        when "q", "quit" then exit(0)
        when "c", "cheat" then print UI::SEQUENCE_MESSAGE % sequence.join.upcase
        else
          guesses += 1
          if input == sequence.join
            time_elapsed = (Time.now - start_time).to_i
            name = get_name_store(sequence, guesses, time_elapsed)
            
            top_ten_list = YAML.load_stream(File.open(UI::DB_STORE)).sort{|player1, player2|
              by_guess = player1.guesses <=> player2.guesses
              by_guess == 0 ? player1.time <=> player2.time : by_guess
            }[0...10]  if File.file?(UI::DB_STORE)
            
            puts UI::CONGRATS_MESSAGE % [name, sequence.join.upcase, guesses, guesses > 1 ? "guesses" : "guess", time_convert(time_elapsed)] 
            puts UI::TOP_TEN
            top_ten_list.each_with_index{|player, index| puts "#{index+1}. " + player.to_s }
            print UI::OPTIONS_MESSAGE + UI::INPUT_PROMPT
            user_choice
            throw :complete
          end
          
          result = GameLogic.check_input(sequence, input)
          history << GamePlay.new(input, result[:correct_elements], result[:correct_position])
          
          puts UI::INFO_MESSAGE % [input.upcase, result[:correct_elements], result[:correct_position]]
          print UI::GUESSES_MESSAGE % [guesses, guesses > 1 ? "guesses" : "guess"]     
        end
      end
    end
  end
end

MasterMind.start