require 'spec_helper'
describe "Multi Player" do
  before do
    allow($stdout).to receive(:write)
  end
  let(:num_of_players) {2}
  let(:max_guess) {12 * num_of_players}
  subject do
    MasterMind::Tobi::MultiPlayer.new(['r', 'g', 'b', 'y', 'g'], MasterMind::Tobi::GameLogic.new(1), false)
  end
  
  describe "instances" do
    context "instances respond to history, sequence, start_time, and gmae_logic properties" do
      it {expect(subject).to respond_to(:sequence)}
      it {expect(subject).to respond_to(:game_logic)}
      it {expect(subject).to respond_to(:hide_guess)}
    end
  end
  
  # describe "MultiPlayer#start_game" do
    # it "gives each player twelve trials to guess right number" do
      # subject.stub(:gets) {
        # @counter ||= 0
        # response = ''
        # if @counter == 0
          # response = 'two'
        # elsif @counter == 1
          # response = num_of_players.to_s
        # elsif @counter == 1
          # response = 'had'
        # elsif @counter == 2
          # response = 'h'
        # else
          # response = 'JJJJJ'
        # end
        # @counter+= 1
        # response
      # }
      # expect(subject.start_game).to eql(max_guess)
    # end
  # end
end