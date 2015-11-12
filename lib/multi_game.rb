require 'single_game'
require 'logic'
require 'ui'

class MultiPlayer < SinglePlayer
  
  def start_game
    number = num_of_players
    end_guess = 12*number + 1
    
    print UI::GENERATE_MESSAGE % [game_logic.sequence_type, game_logic.length, UI::COLOR_STRINGS[game_logic.level]]
    history_hash = {}
    (1..number).each {|x| history_hash[x] = [] }
    
    multi_start_game    
  end  
  
  def multi_start_game
    # allow the user guess up to twelve times before ending game
    guesses = 0
    while guesses < (UI::GUESS_MAX * number)
      for i in (1..number)
        print UI::PLAYER_MESSAGE % i
        input = gets.chomp.downcase
        next if invalid_length(input)
        next if treat_option(input, history_hash[i])
        guesses = treat_guess(input, guesses, history_hash[i])
        break if guesses = end_guess
      end
    end
    puts "Sorry, You all Lost." if guesses == UI::GUESS_MAX * number
  end
  
  def num_of_players
    print UI::MULTI_START_MESSAGE
    input = gets.chomp
    
    while (input.to_i == 0)
      print UI::INVALID_MESSAGE
      input = gets.chomp
    end
    
    return input.to_i
  end
  
end

MultiPlayer.new(['r', 'g', 'y', 'b'], GameLogic.new(0)).start_game
