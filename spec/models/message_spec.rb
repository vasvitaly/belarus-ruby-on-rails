require 'spec_helper'

describe Message do
  subject { Message.new }

  it { should respond_to(:subject) }
  it { should respond_to(:body) }
  it { should have_at_least(1).error_on(:subject) }
  it { should have_at_least(1).error_on(:body) }

  it "is not valid if fake recipient group" do
    message = FactoryGirl.build(:message, :recipient_group => ['42'])
    message.should have_at_least(1).error_on(:recipient_group)
  end

  it "is valid if existing meetup filter" do
    meetup = FactoryGirl.create(:meetup)
    message = FactoryGirl.build(:message, :recipient_group => [meetup.id.to_s])
    message.should be_valid
  end

  it "is not valid if subject is blank" do
    message = FactoryGirl.build(:message, :subject => '' )
    message.should have_at_least(1).error_on(:subject)
  end

  it "is not valid if body is blank" do
    message = FactoryGirl.build(:message, :body => '' )
    message.should have_at_least(1).error_on(:body)
  end
end
