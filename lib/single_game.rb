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
  attr_accessor :end_guess
  
  ALLOWED = ['c', 'h', 'q', 'cheat', 'history', 'quit']
  
  def initialize(sequence, game_logic)
    @start_time = Time.now
    @history = []
    @sequence = sequence
    @game_logic = game_logic
    @end_guess = 13
  end
  
  # generate game sequence and start game play
  def start_game
    print UI::GENERATE_MESSAGE % [game_logic.sequence_type, game_logic.length, UI::COLOR_STRINGS[game_logic.level]]
    print UI::INPUT_PROMPT
    guesses = 0
    
    # allow the user guess up to twelve times before ending game
    while guesses < UI::GUESS_MAX
      input = gets.chomp.downcase
      next if invalid_length(input)
      next if treat_option(input, history)
      guesses = treat_guess(input, guesses, history)
    end
    puts "Sorry, You Lost." if guesses == UI::GUESS_MAX   
  end
  
  # check if user's guess is longer or fewer than the required length
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
  
  # check if user selects an option
  def treat_option(input, history)
    case input
    when "h", "history" then print_history(history)
    when "q", "quit" then exit(0)
    when "c", "cheat" then print UI::SEQUENCE_MESSAGE % sequence.join.upcase
    else return false
    end
    return true
  end
  
  # treat guesses entered by user
  def treat_guess(input, guesses, history)
    guesses += 1
    if input == sequence.join                         # right guess entered
      right_guess(start_time, sequence, guesses)
      guesses = end_guess                             # sentinel value to end guess loop
    else
      wrong_guess(sequence, guesses, input, history)  # wrong guess entered
    end
    
    return guesses
  end
  
  def print_top_ten(current_player)
    top_ten_list = YAML.load_stream(File.open(UI::DB_STORE)).sort{|player1, player2|  # load player objects from db and sort by guesses/time
      by_guess = player1.guesses <=> player2.guesses                                  # first sort by guesses
      by_guess == 0 ? player1.time <=> player2.time : by_guess                        # then sort by time
    }[0...10]  if File.file?(UI::DB_STORE)                                            # pick out top ten
    
    puts average_string(top_ten_list, current_player) if !top_ten_list.nil?           # print out user's performance compared to average
    
    # print out top ten results
    if !top_ten_list.nil?
      puts ""
      puts UI::TOP_TEN                                                                  
      top_ten_list.each_with_index{|player, index| puts "#{index+1}. " + player.to_s }
    end
  end
  
  def right_guess(start_time, sequence, guesses)
    time_elapsed = (Time.now - start_time).to_i                                       # time used by user in seconds
    current_player = store_game(sequence, guesses, time_elapsed)                      # store user data to top-scores file
    
    puts UI::CONGRATS_MESSAGE % [current_player.name, sequence.join.upcase, guesses, guesses > 1 ? "guesses" : "guess", 
      time_convert(time_elapsed) << '.']
    print_top_ten(current_player)
  end
  
  def average_string(top_ten_list, current_player)                                    # generates user's performance compared to average
    # time difference obtained
    time_diff = (top_ten_list.inject(0){ |sum, player| sum += player.time } / top_ten_list.length.to_f).round - current_player.time
    # guess difference obtained
    guess_diff = (top_ten_list.inject(0){ |sum, player| sum += player.guesses } / top_ten_list.length.to_f).round - current_player.guesses
    
    "That's %s %s and %s %s %s the average\n" % [time_convert(time_diff.abs), time_diff < 0 ? "slower" : "faster",
      guess_diff.abs, guess_diff.abs == 1 ? "guess" : "guesses", guess_diff < 0 ? "more" : "fewer"]
  end
  
  def wrong_guess(sequence, guesses, input, history)
    result = GameLogic.check_input(sequence, input)                                       # get results from input
    history << GamePlay.new(input, result[:correct_elements], result[:correct_position])  # add game play to history
    
    puts UI::INFO_MESSAGE % [input.upcase, result[:correct_elements], result[:correct_position]]
    puts UI::GUESSES_MESSAGE % [guesses, guesses > 1 ? "guesses" : "guess"]
    print UI::INPUT_PROMPT
  end
  
  def store_game(sequence, guesses, time)      #get player name and store details to file  
    print UI::NAME_MESSAGE
    name = get_name
    current_player = Player.new(name, sequence, time, guesses)  # create new player object
    
    # write player object to file if file does not exist, or verify whether to add record from user, and write if it exists
    File.open(UI::DB_STORE, 'a'){|file| file.write(YAML.dump(current_player))} if user_permits_store
     
    current_player
  end
  
  def user_permits_store                    # confirm from user to add record to top-scores if file exists
    return true if !File.exist?(UI::DB_STORE)    # if file does not exist, return true
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