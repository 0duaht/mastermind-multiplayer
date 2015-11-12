require 'spec_helper'

describe "Single Player" do
  subject do
    SinglePlayer.new(['r', 'g', 'b', 'y', 'g'], GameLogic.new(1))
  end
  
  describe "instances" do
    context "instances respond to history, sequence, start_time, and gmae_logic properties" do
      it {expect(subject).to respond_to(:history)}
      it {expect(subject).to respond_to(:sequence)}
      it {expect(subject).to respond_to(:start_time)}
      it {expect(subject).to respond_to(:game_logic)}
    end
  end
    
  describe "SinglePlayer#invalid_length" do
    context "able to detect long or too short input values" do
      it "detects when entry is an too short" do
        expect(subject.invalid_length('RGGR')).to eql(true)
      end
      
      it "detects when entry is too long" do
        expect(subject.invalid_length('RGGGRR')).to eql(true)
      end
      
      it "detects when entry is the right length" do 
        expect(subject.invalid_length('RRBOY')).to eql(false)
      end
    end
  end
  
  describe "SinglePlayer#treat_option" do
    context "able to detect when input value is a game option" do
      it "detects when user tries a valid option" do
        expect(subject.treat_option('h')).to eql(true)
        expect(subject.treat_option('cheat')).to eql(true)
      end
      
      it "detects when user tries an invalid option" do
        expect(subject.treat_option('hack')).to eql(false)
      end
    end
  end
end