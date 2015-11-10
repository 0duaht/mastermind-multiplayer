class UI
  WELCOME_MESSAGE = "\t\t\t\t\tWelcome to the Classy MasterMind game\n"
  
  INPUT_PROMPT = "\n\n\t\t\t\t\t\t\t>>  "
  
  OPTIONS_MESSAGE = "\t\t\t\t\t\tWould you like to \n
    \t\t\t\t\t\t (p)lay ?\n\t\t\t\t\t\(r)ead the instructions ?\n\t\t\t\t\t\tor (quit) ?\n\n\t\t\t\t\t\t>>  "
    
  HELP_MESSAGE = "\n\t\t\tOnce game starts, you'll be presented with a range of blank dots, representing a particular code
    \t\tEvery code is a four digit word made up by the letters [r, g, b, y]. You have twelve guesses per game.
    \t\t\t\tOn every guess, you are presented with a message identifying the number of elements you got correctly, and in what positions.\n\n"
 
  GENERATE_MESSAGE = "\n\t\t\tI have generated a beginner sequence with four elements made up of: 
  \t\t\t\t\t(r)ed, (g)reen, (b)lue and (y)ellow.
  \t\t\t\t\tUse (q)uit at any time to end the game. \n\n\t\t\t\t\t\tWhat's your guess?" + INPUT_PROMPT
  
  INVALID_MESSAGE = "\n\t\t\t\t\tEntry invalid! Please try again\n\n\t\t\t\t\t\t" + INPUT_PROMPT
  
  INPUT_SHORT_MESSAGE = "\t\t\t\t\tInput too short. Please enter guess correctly" + INPUT_PROMPT
  
  INPUT_LONG_MESSAGE = "\t\t\t\t\tInput too long. Please enter guess correctly." + INPUT_PROMPT
  
  SEQUENCE_MESSAGE = "\t\t\t\t\t\tThe sequence is %s" + INPUT_PROMPT
  
  CONGRATS_MESSAGE = "\t\t\tCongratulations! You guessed the sequence '%s' in %s "
  
  INFO_MESSAGE = "\t\t\t'%s' has %s of the correct elements with %s in the correct positions."
  
  END_MESSAGE = "\t\t\t\t\tDo you want to (p)lay again or (q)uit?"
  
  TRIES_MESSAGE = "\t\t\t\t\t\tYou've taken %s guess"  + INPUT_PROMPT
    
end