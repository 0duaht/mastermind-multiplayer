require 'ui'
require 'logic'
require 'timehelper'
require 'player'
require 'yaml'
require 'gameplay'
require 'single_game'

module GameHelper
  def user_choice
    option_chosen = false
    
    while !option_chosen
      option_chosen = true                              # assume user selects valid option so as to quit loop
      
      input = gets.chomp.downcase
      option_chosen = validate_input(input)
    end
  end
  
  def validate_input(input)
    case input
      when "p", "play" then play_game
      when "r", "read"
        print_help
        return false                                     # continue loop after displaying help message
      when "q", "quit" then exit
      else                                               # user selects an invalid option
        print UI::INVALID_MESSAGE
        return false
    end
    return true
  end
  
  def play_game
    game_logic = GameLogic.new(ask_level); sequence = game_logic.generate_sequence
    
    SinglePlayer.new(sequence, game_logic).start_game
  end
  
  def print_help
    puts UI::HELP_MESSAGE
    print UI::OPTIONS_MESSAGE
  end
  
  def ask_level
    print UI::LEVEL_MESSAGE
    option_chosen = false
    
    while !option_chosen
      option_chosen = true                              # assume user selects valid level so as to quit loop
      
      input = gets.chomp.downcase
      case input                                        
      when "b", "beginner" then return GameLogic::BEGINNER
      when "i", "intermediate" then return GameLogic::INTERMEDIATE
      when "a", "advanced" then return GameLogic::ADVANCED
      else                                               # user selects an invalid level
        print UI::INVALID_MESSAGE
        option_chosen = false
      end  
    end
  end 
  
end