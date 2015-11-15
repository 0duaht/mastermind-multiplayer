require 'spec_helper'

describe "GameHelper" do
  before do
    allow($stdout).to receive(:write)
  end
  let(:beginner) {0}
  let(:intermediate) {1}
  let(:advanced) {2}
  let(:num_of_players) {2}
  let(:max_guess) {12}
  
  subject do
    MasterMind::Tobi::GameHelper.new
  end
  
  describe "GameHelper#user_choice" do
    it "exits when user chooses to" do
      allow(subject).to receive(:gets).and_return('q')
      expect{subject.user_choice}.to raise_error SystemExit
    end
    
    it "processes user's level correctly" do
      allow(subject).to receive(:gets).and_return('b')
      expect(subject.ask_level).to eql(beginner)
      
      allow(subject).to receive(:gets).and_return('i')
      expect(subject.ask_level).to eql(intermediate)
      
      allow(subject).to receive(:gets).and_return('a')
      expect(subject.ask_level).to eql(advanced) 
    end
    
    it "allows user select to play and play single-player smoothly" do
      Object.any_instance.stub(:gets) {
        @counter ||= 0
        response = ''
        
        if @counter == 0
          response = 'r'
        elsif @counter == 1
          response = 'er'
        elsif @counter == 2
          response = 'p'
        elsif @counter == 3
          response = 'g'   
        elsif @counter == 4
          response = 'b'
        elsif @counter == 5
          response = 's'
        elsif @counter >= 6 && @counter < (max_guess + 1 + 6)
          response = 'JJJJ'
        elsif @counter >= 19
          response = 'q'
        end
        @counter += 1
        response
      }
      expect{subject.user_choice}.to raise_error SystemExit
    end
    
    it "allows user select to play and play multi-player smoothly" do
      Object.any_instance.stub(:gets) {
        @counter ||= 0
        response = ''
        
        if @counter == 0
          response = 'p'
        elsif @counter == 1
          response = 'g'   
        elsif @counter == 2
          response = 'b'
        elsif @counter == 3
          response = 'other'
        elsif @counter == 4
          response = 'm'
        elsif @counter == 5
          response = 'no'
        elsif @counter == 6
          response = num_of_players.to_s
        elsif @counter > 7 && @counter < (max_guess*2 + 1 + 7)
          response = 'JJJJJ'
        else
          response = 'q'
        end
        @counter += 1
        response
      }
      expect{subject.user_choice}.to raise_error SystemExit
    end
  end
end
