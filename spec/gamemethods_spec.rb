require 'spec_helper'

describe "GameMethods" do
  before do
    allow($stdout).to receive(:write)
  end
  
  subject do
    MasterMind::Tobi::GameMethods.new
  end
  
  let(:game_play) {[MasterMind::Tobi::GamePlay.new('srrt', 2, 1), MasterMind::Tobi::GamePlay.new('grrb', 3, 2)]}
end
