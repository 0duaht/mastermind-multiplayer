require 'spec_helper'
describe GameHelper do
  describe "#validate_input" do
    it "returns false when passed an invalid input" do
      expect(MasterMind.validate_input('g')).to eql(false)
    end
  end
end