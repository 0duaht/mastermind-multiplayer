lib_master = File.expand_path('../../lib/mastermind/tobi', __FILE__)
$LOAD_PATH.unshift(lib_master) unless $LOAD_PATH.include?(lib_master)

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'timehelper'
require 'player'
require 'logic'
require 'gameplay'
require 'gamehelper'
require 'single_game'
require 'ui'
require 'gamemethods'
require 'multi_game'
