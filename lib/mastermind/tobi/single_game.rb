require 'ui'
require 'timehelper'
require 'player'
require 'yaml'
require 'gameplay'
require 'gamemethods'

module MasterMind
  module Tobi
    class SinglePlayer
      extend GameMethods
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
        #print UI::GENERATE_MESSAGE % [game_logic.sequence_type, game_logic.length, UI::COLOR_STRINGS[game_logic.level]]
        #print UI::INPUT_PROMPT
        
        # allow the user guess up to twelve times before ending game
        guesses = 0
        while guesses < UI::GUESS_MAX
          guesses = process_input(guesses, history)
        end
        puts UI::SORRY_SINGLE_MESSAGE % sequence.join.upcase if guesses == UI::GUESS_MAX   
      end
      
      def process_input(guesses, history)
        input = gets.chomp.downcase
        length_or_option = false
        
        length_or_option = invalid_length?(input)
        
        if !length_or_option
          length_or_option = treat_option?(input, history)
        end
        
        if !length_or_option
          guesses = treat_guess(input, guesses, history)
        end
        guesses
      end
      
      # check if user's guess is longer or fewer than the required length
      def invalid_length?(input)   
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
      def treat_option?(input, history)
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
      
      def right_guess(start_time, sequence, guesses)
        time_elapsed = (Time.now - start_time).to_i                                       # time used by user in seconds
        current_player = store_game(sequence, guesses, time_elapsed)                      # store user data to top-scores file
        
        puts UI::CONGRATS_MESSAGE % [current_player.name, sequence.join.upcase, guesses, guesses > 1 ? "guesses" : "guess", 
          time_convert(time_elapsed) << '.']
        print_top_ten(current_player)
      end
      
      def wrong_guess(sequence, guesses, input, history)
        result = GameLogic.check_input(sequence, input)                                       # get results from input
        history << GamePlay.new(input, result[:correct_elements], result[:correct_position])  # add game play to history
        
        puts UI::INFO_MESSAGE % [input.upcase, result[:correct_elements], result[:correct_position]]
        puts UI::GUESSES_MESSAGE % [guesses, guesses > 1 ? "guesses" : "guess"]
        print UI::INPUT_PROMPT
      end
      
    end
  end
end