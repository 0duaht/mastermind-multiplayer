require_relative 'spec_helper'

describe Player do
  subject do
    Player.new("Jane Doe", ['r', 'g', 'b', 'r'], 128, 5)
  end
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:sequence) }
  it { is_expected.to respond_to(:time) }
  it { is_expected.to respond_to(:guesses) }
  it "prints out appropriately" do
     expect(subject.to_s).to eql("Jane Doe solved 'RGBR' in 5 guesses over 2 minutes, 8 seconds.")
  end
end
