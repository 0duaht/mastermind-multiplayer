require 'spec_helper'
describe GameHelper do
  before do
    allow($stdout).to receive(:write)
  end
  
  describe "#validate_input" do
    it "returns false when passed an invalid input" do
      expect(MasterMind.validate_input('g')).to eql(false)
    end
  end
end