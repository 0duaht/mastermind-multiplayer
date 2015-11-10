class UI
  WELCOME_MESSAGE = "\nWelcome to the Classy MasterMind game by Tobi\n"
  
  INPUT_PROMPT = "\n>>  "
  
  OPTIONS_MESSAGE = "\nWould you like to (p)lay, (r)ead the instructions or (quit) ?"
    
  HELP_MESSAGE = "\nOnce game starts, you'll be presented with a range of blank dots, representing a particular code
Every code is a four digit word made up by the letters [r, g, b, y]. You have twelve guesses per game.
On every guess, you are presented with a message identifying the number of elements you got correctly, and in what positions.\n\n"
  
  BEGINNER_COLOR = "(r)ed, (g)reen, (b)lue and (y)ellow"
  
  INTERMEDIATE_COLOR = "(r)ed, (g)reen, (b)lue, (y)ellow, and (o)range"
  
  ADVANCED_COLOR = "(r)ed, (g)reen, (b)lue, (y)ellow, (o)range and (v)iolet"
 
  COLOR_STRINGS = [BEGINNER_COLOR, INTERMEDIATE_COLOR, ADVANCED_COLOR]
  
  GENERATE_MESSAGE = "\nI have generated a beginner sequence with four elements made \
up of: %s\nUse (q)uit at any time to end the game. \nWhat's your guess?" + INPUT_PROMPT
  
  INVALID_MESSAGE = "\nEntry invalid! Please try again" + INPUT_PROMPT
  
  INPUT_SHORT_MESSAGE = "Input too short. Please enter guess correctly" + INPUT_PROMPT
  
  INPUT_LONG_MESSAGE = "Input too long. Please enter guess correctly." + INPUT_PROMPT
  
  SEQUENCE_MESSAGE = "The sequence is %s" + INPUT_PROMPT
  
  CONGRATS_MESSAGE = "\n%s, You guessed the sequence '%s' in %s %s over %s\n\n"
  
  INFO_MESSAGE = "'%s' has %s of the correct elements with %s in the correct positions."
  
  END_MESSAGE = "Do you want to (p)lay again or (q)uit?"
  
  GUESSES_MESSAGE = "You've taken %s %s"  + INPUT_PROMPT
  
  LEVEL_MESSAGE = "\nDifficulty level: (b)eginner, (i)ntermediate or (a)dvanced? " + INPUT_PROMPT
  
  NAME_MESSAGE = "\nCongratulations! You've guessed the sequence! What's your name?" + INPUT_PROMPT
  
  DB_STORE = 'store.yaml'
  
  TOP_TEN = '=== TOP TEN ==='
end