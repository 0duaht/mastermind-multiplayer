require_relative 'spec_helper'
describe TimeHelper do
  let(:test_class) {Class.new{extend TimeHelper}}
  describe "#time_convert" do
    it "returns the right time given a specified number of seconds" do
       expect(test_class.time_convert(166)).to eql("2 minutes, 46 seconds.")
    end
  end
end