require 'spec_helper'

describe Question do
  it { should allow_mass_assignment_of :answers_attributes }
  it { should allow_mass_assignment_of :gist }
  it { should allow_mass_assignment_of :kind_of_response }
  it { should allow_mass_assignment_of :required }
  it { should allow_mass_assignment_of :min_length }
  it { should allow_mass_assignment_of :length }
  it { should allow_mass_assignment_of :max_length }
  it { should belong_to(:meetup) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:quizzes).dependent(:destroy) }
  it { should accept_nested_attributes_for(:answers).allow_destroy(true) }
  it { should have(1).error_on(:gist) }

  it 'all response types should be listed in options for select' do
    Question::RESPONSE_TYPES.length.should eq(Question.response_type_options_for_select.length)
  end
end
