lib_master = File.expand_path('../mastermind/tobi', __FILE__)
$LOAD_PATH.unshift(lib_master) unless $LOAD_PATH.include?(lib_master)
require 'ui'
require 'gamehelper'

module MasterMind
  module Tobi
    VERSION = 1.0
    extend MasterMind::Tobi::GameHelper
    
    def self.start
      puts MasterMind::Tobi::UI::WELCOME_MESSAGE
      print MasterMind::Tobi::UI::OPTIONS_MESSAGE + MasterMind::Tobi::UI::INPUT_PROMPT
      user_choice
    end
  end
end