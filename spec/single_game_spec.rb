require 'spec_helper'
describe "Single Player" do
  before do
    allow($stdout).to receive(:write)
  end
  
  subject do
    MasterMind::Tobi::SinglePlayer.new(['r', 'g', 'b', 'y', 'g'], MasterMind::Tobi::GameLogic.new(1))
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
        expect(subject.invalid_length?('RGGR')).to eql(true)
      end
      
      it "detects when entry is too long" do
        expect(subject.invalid_length?('RGGGRR')).to eql(true)
      end
      
      it "detects when entry is the right length" do 
        expect(subject.invalid_length?('RRBOY')).to eql(false)
      end
    end
  end
  
  describe "SinglePlayer#treat_option" do
    context "able to detect when input value is a game option" do
      it "detects when user tries a valid option" do
        expect(subject.treat_option?('h', [])).to eql(true)
        expect(subject.treat_option?('cheat', [])).to eql(true)
      end
      
      it "detects when user tries an invalid option" do
        expect(subject.treat_option?('hack', [])).to eql(false)
      end
      
      it "detects when user tries to quit" do
        expect{subject.treat_option?('q', [])}.to raise_error SystemExit
      end
    end
  end
  
  describe "SinglePlayer#treat_guess" do
    let(:end_guess) {13}
    it "confirms when user guess is right" do
      allow(subject).to receive(:gets).and_return('James')
      allow(subject).to receive(:user_permits_store?).and_return(true)
      expect(subject.treat_guess('rgbyg', 4, [])).to eql(end_guess)
    end
    
    it "confirms when user guess is wrong" do
      expect(subject.treat_guess('rgby', 5, [])).to eql(6)
    end
  end
  
  describe "SinglePlayer#process_input" do
    it "process input correctly" do
      allow(subject).to receive(:gets).and_return('rgbvb')
      expect(subject.process_input(7, [])).to eql(8)
    end
  end
end