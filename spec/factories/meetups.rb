FactoryGirl.define do
  factory :meetup do
    topic 'Topic of meetup'
    description 'Description of meetup'
    place 'Minsk, Belarus'
    letter_subject 'Letter subject'
    letter_body 'Letter body'
    date_and_time Time.now + 1.day
    finish_date_and_time Time.now + 1.month
  end

  factory :meetup_ical, :class => Meetup do
    topic 'Topic of meetup'
    description 'Description of meetup'
    date_and_time 'Thu May 22 16:30:00 -0400 2008'
    finish_date_and_time 'Thu May 22 18:30:00 -0400 2008'
  end
end
