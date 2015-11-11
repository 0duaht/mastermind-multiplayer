require_relative 'spec_helper'

describe GamePlay do
  subject do
    GamePlay.new("rggy", 2, 1)
  end
  
  it "prints out appropriately" do
    expect(subject.to_s).to eql("rggy ::: 2 correct elements ::: 1 in correct position")
  end
  
end
