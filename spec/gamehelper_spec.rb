require 'spec_helper'

describe "GameHelper" do
  before do
    #allow($stdout).to receive(:write)
  end
  
  subject do
    MasterMind::Tobi::GameHelper.new
  end
  
  describe "GameHelper#user_choice" do
    it "exits when user chooses to" do
      allow(subject).to receive(:gets).and_return('q')
      expect{subject.user_choice}.to raise_error SystemExit
    end
    
    it "allows user select other options" do
      Object.any_instance.stub(:gets) {
        @counter ||= 0
        response = ''
        
        if @counter == 0
          response = 'p'
        elsif @counter == 1
          response = 'b'
        elsif @counter == 2
          response = 's'
        elsif @counter == 3
          response = 'q'
        end
        @counter += 1
        response
      }
      expect{subject.user_choice}.to raise_error SystemExit
    end
  end
end
