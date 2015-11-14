require 'spec_helper'
describe "GameHelper" do
  before do
    allow($stdout).to receive(:write)
  end
  
  let(:test_subj) { MasterMind::Tobi::GameHelper.new}
  
  describe "#validate_input" do
    it "returns false when passed an invalid input" do
      expect(test_subj.validate_input?('g')).to eql(false)
    end
  end
end