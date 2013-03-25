require "spec_helper"

describe Notifier do
  describe '.broadcast_message' do
    let(:user) { FactoryGirl.build_stubbed(:user) }
    let(:message) { Message.new(FactoryGirl.attributes_for(:message)) }
    let(:mail) { Notifier.broadcast_message(user.email, message.subject, message.body) }

    it 'renders the subject' do
      mail.subject.should eq(message.subject)
    end

    it 'renders the body' do
      mail.body.should include(message.body)
    end

    it 'renders the receiver email' do
      mail.to.should == [user.email]
    end
  end

  describe '.comment' do
    let(:user) { FactoryGirl.build_stubbed(:user) }
    let(:article) { FactoryGirl.build_stubbed(:article) }
    let(:mail) { Notifier.comment(article) }

    it 'renders the article title' do
      mail.body.should include(article.title)
    end

    it 'renders the receiver email' do
      mail.to.should == ["info@belarusrubyonrails.org"]
    end
  end
end
