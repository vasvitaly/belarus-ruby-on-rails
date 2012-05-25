# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quiz do
      participant_id 1
      question_id 1
      answer "MyString"
    end
end