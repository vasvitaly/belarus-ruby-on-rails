require 'spec_helper'

describe Quiz do
  it { should allow_mass_assignment_of :question }
  it { should allow_mass_assignment_of :answer }
  it { should allow_mass_assignment_of :question_id }
  it { should belong_to(:participant) }
  it { should belong_to(:question) }

  context 'should validate' do
    subject { mock(:question => {:required => true}).as_null_object }

    it 'answer_presence' do
      subject.stub(:answer) { '' }
      subject.send :answer_presence
      subject.errors[:answer].should include(I18n.t('meetup.can_not_be_blank'))
    end

    it 'one_answer_must_be_checked' do
      subject.stub(:answer) { [] }
      subject.send :one_answer_must_be_checked
      subject.errors[:answer].should include(I18n.t('meetup.nothing_selected'))
    end
  end

  context 'should validate answer_length' do
    subject { mock(:answer => 'MyString', :question => {:kind_of_response => 2}).as_null_object }

    it 'with wrong min_length' do
      subject.stub_chain(:question, :min_length) { 9 }
      subject.send :answer_length
      subject.errors[:answer].should include(I18n.t('meetup.can_not_be_less_than', :min_length => 9))
    end

    it 'with wrong length' do
      subject.stub_chain(:question, :length) { 9 }
      subject.send :answer_length
      subject.errors[:answer].should include(I18n.t('meetup.must_be_equal_to', :length => 9))
    end

    it 'with wrong max_length' do
      subject.stub_chain(:question, :max_length) { 7 }
      subject.send :answer_length
      subject.errors[:answer].should include(I18n.t('meetup.can_not_be_greater_than', :max_length => 7))
    end
  end
end
