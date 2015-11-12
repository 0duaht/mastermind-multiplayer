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
end