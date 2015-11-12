require 'ui'
require 'timehelper'
require 'player'
require 'yaml'
require 'gameplay'

class SinglePlayer
  
  include TimeHelper
  
  attr_reader :start_time
  attr_reader :history
  attr_reader :sequence
  attr_reader :game_logic
  
  ALLOWED = ['c', 'h', 'q', 'cheat', 'history', 'quit']
  END_GUESS = 13
  
  def initialize(sequence, game_logic)
    @start_time = Time.now
    @history = []
    @sequence = sequence
    @game_logic = game_logic
  end
  
  def start_game
    print UI::GENERATE_MESSAGE % UI::COLOR_STRINGS[game_logic.level]
    guesses = 0
    
    while guesses < 12
      input = gets.chomp.downcase
      next if invalid_length(input)
      next if treat_option(input)
      guesses = treat_guess(input, guesses)
    end
  end
  
  def invalid_length(input)
    if input.length < game_logic.length && !(ALLOWED.include?(input))
      print UI::INPUT_SHORT_MESSAGE
      return true
      
    elsif input.length > game_logic.length && !(ALLOWED.include?(input)) 
      print UI::INPUT_LONG_MESSAGE
      return true
    end
    
    return false
  end
  
  def treat_option(input)
    case input
    when "h", "history" then print_history(history)
    when "q", "quit" then exit(0)
    when "c", "cheat" then print UI::SEQUENCE_MESSAGE % sequence.join.upcase
    else return false
    end
    return true
  end
  
  def treat_guess(input, guesses)
    guesses += 1
    if input == sequence.join
      right_guess(start_time, sequence, guesses)
      guesses = END_GUESS
    end
    
    wrong_guess(sequence, guesses, input, history)
    return guesses
  end
  
  def print_top_ten
    top_ten_list = YAML.load_stream(File.open(UI::DB_STORE)).sort{|player1, player2|  # load player objects from db and sort by guesses/time
      by_guess = player1.guesses <=> player2.guesses
      by_guess == 0 ? player1.time <=> player2.time : by_guess
    }[0...10]  if File.file?(UI::DB_STORE) 
    
    puts UI::TOP_TEN
    top_ten_list.each_with_index{|player, index| puts "#{index+1}. " + player.to_s }
  end
  
  def right_guess(start_time, sequence, guesses)
    time_elapsed = (Time.now - start_time).to_i
    name = store_game(sequence, guesses, time_elapsed)
    
    puts UI::CONGRATS_MESSAGE % [name, sequence.join.upcase, guesses, guesses > 1 ? "guesses" : "guess", time_convert(time_elapsed)]
    print_top_ten
    print UI::OPTIONS_MESSAGE + UI::INPUT_PROMPT
    user_choice
  end
  
  def wrong_guess(sequence, guesses, input, history)
    result = GameLogic.check_input(sequence, input)                                       # get results from input
    history << GamePlay.new(input, result[:correct_elements], result[:correct_position])  # add game play to history
    
    puts UI::INFO_MESSAGE % [input.upcase, result[:correct_elements], result[:correct_position]]
    print UI::GUESSES_MESSAGE % [guesses, guesses > 1 ? "guesses" : "guess"]
  end
  
  def store_game(sequence, guesses, time)      #get player name and store details to file  
    print UI::NAME_MESSAGE
    name = get_name
    current_player = Player.new(name, sequence, time, guesses)  # create new player object
    
    # write player object to file if file does not exist, or verify whether to add record from user, and write if it exists
    File.open(UI::DB_STORE, 'a'){|file| file.write(YAML.dump(current_player))} if File.exist?(UI::DB_STORE) && user_permits_store
     
    name
  end
  
  def user_permits_store
    print UI::OVERWRITE_MESSAGE
    print UI::INPUT_PROMPT
    option_chosen = false
    
    while !option_chosen
      option_chosen = true                              # assume user selects valid option so as to quit loop
      
      input = gets.chomp.downcase
      case input                                        
      when "y", "yes" then return true
      when "n", "no" then return false
      else                                               # user selects an invalid option
        print UI::INVALID_MESSAGE
        option_chosen = false
      end  
    end
  end
  
  def get_name
    name = ""
    
    while name.eql?("")
      name = gets.chomp.capitalize
      print UI::INVALID_MESSAGE if name.eql?("")  
    end
    
    name
  end
   
  def print_history(history)
    if history.empty?
      print "No history yet. Enter a guess"  + UI::INPUT_PROMPT
    else
      puts ""
      puts history
      print UI::INPUT_PROMPT 
    end
  end
end