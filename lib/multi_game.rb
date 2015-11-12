require 'single_game'
require 'logic'
require 'ui'

class MultiPlayer < SinglePlayer
  
  def start_game
    number = num_of_players
    end_guess = 12*number + 1
    
    puts UI::GENERATE_MESSAGE % [game_logic.sequence_type, game_logic.length, UI::COLOR_STRINGS[game_logic.level]]
    history_hash = {}
    guesses_hash = {}
    (1..number).each {|x| 
      history_hash[x] = []
      guesses_hash[x] = 0 
    }
    
    multi_start_game(number, history_hash, guesses_hash)    
  end  
  
  def multi_start_game(number, history_hash, guesses_hash)
    total_guesses = 0                                       # total guesses of all players
    catch :player_wins do
      while total_guesses < (UI::GUESS_MAX * number)        # until all players have exhausted their guesses
        for i in (1..number)                                # loop through to allow each player have a guess
          total_guesses += 1
          last_guess = guesses_hash[i]                      # to store player's last guess
          print "************"
          print UI::PLAYER_MESSAGE % i
          while guesses_hash[i] == last_guess               # to counter situations where user enters invalid input, guess would still be same
            guesses_hash[i] = get_guess(history_hash, guesses_hash, i)
            throw(:player_wins) if guesses_hash[i] == end_guess # if there is a win
          end
        end
      end
    end
    puts UI::SORRY_MULTI_MESSAGE % sequence.join.upcase if total_guesses == UI::GUESS_MAX * number # guesses exhausted with no winner
  end
  
  def get_guess(history_hash, guesses_hash, i)
    input = gets.chomp.downcase
    next if invalid_length(input)                            # invalid length for entry
    next if treat_option(input, history_hash[i])             # entry is a game option
    guesses_hash[i] = treat_guess(input, guesses_hash[i], history_hash[i])  # player enters a guess
  end
  
  def num_of_players
    print UI::MULTI_START_MESSAGE
    input = gets.chomp
    
    while (input.to_i <= 1)
      print UI::INVALID_MESSAGE
      input = gets.chomp
    end
    
    return input.to_i
  end
end
