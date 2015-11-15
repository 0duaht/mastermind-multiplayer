require 'single_game'
require 'logic'
require 'ui'
require 'io/console'

module MasterMind
  module Tobi
    class MultiPlayer < SinglePlayer
      attr_reader :hide_guess
      
      def initialize(sequence, game_logic, hide_guess)
        super(sequence, game_logic)
        @hide_guess = hide_guess  
      end
      
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
            for index in (1..number)                                # loop through to allow each player have a guess
              total_guesses += 1
              multi_helper(guesses_hash, index, history_hash)
            end
          end
        end
        puts UI::SORRY_MULTI_MESSAGE % sequence.join.upcase if total_guesses == UI::GUESS_MAX * number # guesses exhausted with no winner
        total_guesses
      end
      
      def multi_helper(guesses_hash, index, history_hash)
        last_guess = guesses_hash[index]                      # to store player's last guess
        print "************"
        print UI::PLAYER_MESSAGE % index
        while guesses_hash[index] == last_guess               # to counter situations where user enters invalid input, guess would still be same
          guesses_hash[index] = get_guess(history_hash, guesses_hash, index)
          throw(:player_wins) if guesses_hash[index] == end_guess # if there is a win
        end
      end
      
      def get_guess(history_hash, guesses_hash, index)
        input = hide_guess ? STDIN.noecho(&:gets).chomp : gets.chomp
        
        length_or_option = false
        length_or_option = invalid_length?(input)                            # invalid length for entry
        
        if !length_or_option
          length_or_option = treat_option?(input, history_hash[index])             # entry is a game option
        end
        
        if !length_or_option
          guesses_hash[index] = check_help(input, guesses_hash, history_hash, index)
        end
        
        guesses_hash[index]
      end
      
      def check_help(input, guesses_hash, history_hash, index)
        treat_guess(input, guesses_hash[index], history_hash[index])  # player enters a guess
      end
      
      def wrong_guess(sequence, guesses, input, history)
        result = GameLogic.check_input(sequence, input)                                       # get results from input
        history << GamePlay.new(input, result[:correct_elements], result[:correct_position])  # add game play to history
        
        puts UI::INFO_MESSAGE % [hide_guess ? "Your Guess" : input.upcase, result[:correct_elements], result[:correct_position]]
        puts UI::GUESSES_MESSAGE % [guesses, guesses > 1 ? "guesses" : "guess"]
        print UI::INPUT_PROMPT
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
  end
end
