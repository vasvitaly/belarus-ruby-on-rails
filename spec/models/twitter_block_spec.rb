require 'spec_helper'

describe TwitterBlock do
  it "should be valid" do
    twitter_block = FactoryGirl.build(:twitter_block)
    twitter_block.should be_valid
  end

  it "should not be valid without widget" do
    twitter_block = FactoryGirl.build(:twitter_block, :widget => "")
    twitter_block.should have(1).error_on(:widget)
  end
end
