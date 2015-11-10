require_relative 'spec_helper'

describe GameLogic do
  subject do
    [GameLogic.new(0), GameLogic.new(1), GameLogic.new(2)]  
  end
  let(:random) { rand(3) }
  
  describe "instances" do
    context "instances respond to level, length and color_array properties" do
      
      it {expect(subject[random]).to respond_to(:level)}
      it {expect(subject[random]).to respond_to(:length)}
      it {expect(subject[random]).to respond_to(:color_array)}
    end
  
    context "return right number of characters for different levels" do
      it "returns 4-digit color for beginner level" do
        expect(subject[0].generate_sequence.length).to eql(4)
      end
      
      it "returns 5-digit color for intermediate level" do
        expect(subject[1].generate_sequence.length).to eql(5)
      end
      
      it "returns 6-digit color for beginners" do
        expect(subject[2].generate_sequence.length).to eql(6)
      end  
    end
  end
  
  
  describe "#check_input" do
    it "calculates number of correct elements and correct positions" do
      expect(GameLogic.check_input(['r', 'r', 'y', 'b', 'v'], 'rvoby')).to eq({correct_elements: 4, correct_position: 2}) 
    end
  end
end