class GamePlay
  attr_reader :entry
  attr_reader :correct_elements
  attr_reader :correct_positions
  
  def initialize(entry, correct_elements, correct_positions)
    @entry = entry
    @correct_elements = correct_elements
    @correct_positions = correct_positions
  end
  
  def to_s
    "#{entry} ::: #{correct_elements} correct elements ::: #{correct_positions} correct positions"
  end
end