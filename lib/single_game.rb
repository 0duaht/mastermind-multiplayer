require 'ui'

class SinglePlayer
  attr_reader :start_time
  attr_reader :history
  attr_reader :sequence
  attr_reader :game_logic
  
  ALLOWED = ['c', 'h', 'q', 'cheat', 'history', 'quit']
  END_GUESS = 13
  
  def initialize(sequence, game_logic)
    @start_time = Time.now
    history = []
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
      puts UI::INPUT_SHORT_MESSAGE
      return true
      
    elsif input.length > game_logic.length && !(ALLOWED.include?(input)) 
      puts UI::INPUT_LONG_MESSAGE
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
end