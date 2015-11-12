require 'ui'
require 'gamehelper'

module MasterMind
  VERSION = 1.0
  extend GameHelper
  
  def self.start
    puts UI::WELCOME_MESSAGE
    print UI::OPTIONS_MESSAGE + UI::INPUT_PROMPT
    
    user_choice
  end
 
 
#MasterMind.start
  # def play_game
    # game_logic = GameLogic.new(ask_level); sequence = game_logic.generate_sequence
    # print UI::GENERATE_MESSAGE % UI::COLOR_STRINGS[game_logic.level]
    # start_time = Time.now; guesses = 0; allowed = ['c', 'h', 'q', 'cheat', 'history', 'quit']; history = []
#     
    # catch :complete do
      # while guesses < 12
        # input = gets.chomp.downcase
#           
        # if input.length < game_logic.length && !(allowed.include?(input))
          # puts UI::INPUT_SHORT_MESSAGE
          # next
#           
        # elsif input.length > game_logic.length && !(allowed.include?(input)) 
          # puts UI::INPUT_LONG_MESSAGE
          # next 
        # end
#         
        # case input
        # when "h", "history" then print_history(history)
        # when "q", "quit" then exit(0)
        # when "c", "cheat" then print UI::SEQUENCE_MESSAGE % sequence.join.upcase
        # else
          # guesses += 1
          # if input == sequence.join
            # right_guess(start_time, sequence, guesses)
            # throw :complete
          # end
#           
          # wrong_guess(sequence, guesses, input, history)     
        # end
      # end
    # end
  # end
end