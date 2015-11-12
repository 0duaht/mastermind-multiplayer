require 'single_game'
require 'logic'
require 'ui'

class MultiPlayer < SinglePlayer
  
  def start_game
    number = num_of_players
    
    print UI::GENERATE_MESSAGE % [game_logic.sequence_type, game_logic.length, UI::COLOR_STRINGS[game_logic.level]]
    guesses = 0
    
    # allow the user guess up to twelve times before ending game
    while guesses < 12
      input = gets.chomp.downcase
      next if invalid_length(input)
      next if treat_option(input)
      guesses = treat_guess(input, guesses)
    end
    puts "Sorry, You Lost." if guesses == 12    
  end  
  
  def num_of_players
    print UI::MULTI_START_MESSAGE
    input = gets.chomp
    
    while (input.to_i == 0)
      print UI::INVALID_MESSAGE
    end
    
    return input.to_i
  end
  
end

MultiPlayer.new(['r', 'g', 'b', 'v'], GameLogic.new(1)).start_game