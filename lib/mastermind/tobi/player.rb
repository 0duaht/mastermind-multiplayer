require 'timehelper'

module MasterMind
  module Tobi
    class Player
      attr_reader :name
      attr_reader :sequence
      attr_reader :time
      attr_reader :guesses
      include TimeHelper
      
      def initialize(name, sequence, time, guesses)
        @name = name; @sequence = sequence; @time = time; @guesses = guesses
      end
      
      def to_s
        "%s solved '%s' in %s %s over %s" % [name, sequence.join.upcase, guesses, guesses > 1 ? "guesses" : "guess", time_convert(time)]  
      end
    end
  end
end