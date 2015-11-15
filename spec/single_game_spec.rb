require 'spec_helper'
describe "Single Player" do
  before do
    allow($stdout).to receive(:write)
  end
  
  subject do
    MasterMind::Tobi::SinglePlayer.new(['r', 'g', 'b', 'y', 'g'], MasterMind::Tobi::GameLogic.new(1))
  end
  let(:end_guess) {13}
  let(:max_guess) {12}
  let(:game_play) {[MasterMind::Tobi::GamePlay.new('srrt', 2, 1), MasterMind::Tobi::GamePlay.new('grrb', 3, 2)]}
  
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
        expect(subject.treat_option?('h', game_play)).to eql(true)
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
  
  describe "SinglePlayer#start_game" do
    it "gives user twelve trials to guess right number" do
      allow(subject).to receive(:gets).and_return(subject.sequence.join+'\n')
      allow(subject).to receive(:gets).and_return('JJJJJ')
      expect(subject.start_game).to eql(max_guess)
    end
  end
  
  describe "SinglePlayer#user_permits_store?" do
    it "stores when user agress to store" do
      allow(subject).to receive(:gets).and_return("yes")
      expect(subject.user_permits_store?).to eql(true)
      allow(subject).to receive(:gets).and_return("no")
      expect(subject.user_permits_store?).to eql(false)
          
      subject.stub(:gets) {
        @counter ||= 0
        response = ''
        if @counter > 2
          response = 'no'
        else
          response = 'help'
          @counter+= 1
        end
        response
      }
      expect(subject.user_permits_store?).to eql(false)
    end
  end
end