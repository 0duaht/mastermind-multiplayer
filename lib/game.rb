class Game
  attr_reader :length
  attr_reader :chars
  attr_reader :tries
  
  def initialize(length, chars)
    @length = length
    @chars = chars
    @tries = 0
  end
  
  def increase_tries
    @tries = @tries.next
  end
  
  private
  def tries=(v)
    tries = v
  end
   
end