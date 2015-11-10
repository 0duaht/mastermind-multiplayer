require 'timehelper'

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
    "%s solved '%s' in %s guesses over %s" % [name, sequence.join.upcase, guesses, time_convert(time)]  
  end
end