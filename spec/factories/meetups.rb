FactoryGirl.define do
  factory :meetup do
    topic 'Topic of meetup'
    description 'Description of meetup'
    place 'Minsk, Belarus'
    date_and_time '2022-12-31 09:00:00 +0300'
    letter_subject 'Letter subject'
    letter_body 'Letter body'
  end
end
