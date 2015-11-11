class GameLogic
  attr_reader :level; attr_reader :length; attr_reader :color_array
  
  BEGINNER, INTERMEDIATE, ADVANCED = 0, 1, 2
  COLORS = [['r', 'g', 'b', 'y'], ['r', 'g', 'b', 'y', 'o'], ['r', 'g', 'b', 'y', 'o', 'v']]
  
  def initialize(level)
    @level = level
    @color_array = COLORS[level]
    @length = color_array.length
  end
  
  def generate_sequence
    (color_array * (rand() * 1000).to_i).shuffle[0...color_array.length]                  # generate random combination of r/g/b/y
  end
  
  def self.check_input(sequence, input)
    verify_values(input.split(''), sequence, sequence[0..-1])
  end
  
  def self.verify_values(split_input, sequence, sequence_copy)
    result_values = {correct_elements: 0, correct_position: 0}
    split_input.each_with_index{ |element, index| 
      result_values[:correct_position] += 1 if split_input[index] == sequence[index] # if element in correct position
      if sequence_copy.include?(element)
        result_values[:correct_elements] += 1
        sequence_copy.delete_at(sequence_copy.index(element))         # if in sequence, delete first occurrence so as to counter duplicates
      end 
    }
    result_values
  end
  
end