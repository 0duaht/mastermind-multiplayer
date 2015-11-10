require "tobi/mastermind/version"

require_relative 'ui'
require_relative 'logic'

def home_screen
  puts UI::WELCOME_MESSAGE
  print UI::OPTIONS_MESSAGE
  
  user_choice
end

def user_choice
  option_chosen = false
  
  while !option_chosen
    option_chosen = true                              # assume user selects valid option so as to quit loop
    
    input = gets.chomp.downcase
    case input
    when "p", "play" then play_game
    when "r", "read"
      puts UI::HELP_MESSAGE
      print UI::OPTIONS_MESSAGE
      option_chosen = false
    when "q", "quit" then exit(0)
    else                                               # user selects an invalid option
      print UI::INVALID_MESSAGE
      option_chosen = false
    end  
  end
end

def play_game
  sequence = GameLogic.generateSequence
  print UI::GENERATE_MESSAGE
  tries = 0
  
  catch :complete do
    while tries < 12
      input = gets.chomp.downcase
        
      if input.length < 4 && !(input.eql?('c') || input.eql?('q'))
        puts UI::INPUT_SHORT_MESSAGE
        next
        
      elsif input.length > 4 && !(input.eql?("cheat")) 
        puts UI::INPUT_LONG_MESSAGE
        next 
      end
      
      case input
      when "q", "quit" then exit(0)
      when "c", "cheat" then print UI::SEQUENCE_MESSAGE % sequence.join.upcase
      else
        tries += 1
        if input == sequence.join
          puts UI::CONGRATS_MESSAGE % [sequence.join.upcase, tries] +  (tries > 1 ? "guesses" : "guess")
          #puts UI::END_MESSAGE 
          user_choice
          throw :complete
        end
        
        GameLogic.check_input(sequence, input, tries)     
      end
    end
  end
end

home_screen

