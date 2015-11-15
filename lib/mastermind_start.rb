lib_master = File.expand_path('../mastermind/tobi', __FILE__)
$LOAD_PATH.unshift(lib_master) unless $LOAD_PATH.include?(lib_master)
require 'ui'
require 'gamehelper'

module MasterMind
  module Tobi
    VERSION = 1.0
    
    def self.start
      gamehelper = GameHelper.new
      puts UI::WELCOME_MESSAGE
      print UI::OPTIONS_MESSAGE + UI::INPUT_PROMPT
      gamehelper.user_choice
    end
  end
end