require 'spec_helper'
describe "TimeHelper" do
  before do
    allow($stdout).to receive(:write)
  end
  let(:test_class) {Class.new{extend MasterMind::Tobi::TimeHelper}}
  describe "#time_convert" do
    it "returns the right time given a specified number of seconds" do
       expect(test_class.time_convert(166)).to eql("2 minutes, 46 seconds")
    end
  end
end