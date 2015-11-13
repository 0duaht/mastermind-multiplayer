lib_master = File.expand_path('../mastermind/tobi', __FILE__)
$LOAD_PATH.unshift(lib_master) unless $LOAD_PATH.include?(lib_master)
require 'ui'
require 'gamehelper'

module MasterMind
  module Tobi
    extend MasterMind::Tobi::GameHelper
    VERSION = 1.0
    
    def self.start
      puts UI::WELCOME_MESSAGE
      print UI::OPTIONS_MESSAGE + UI::INPUT_PROMPT
      user_choice
    end
  end
end

MasterMind::Tobi.start