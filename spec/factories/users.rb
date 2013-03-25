FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'

    after(:build) do |user|
      user.skip_confirmation!
      user.profile ||= FactoryGirl.build(:profile)
    end

    after(:stub) do |user|
      user.confirmed_at = Time.now
      user.confirmation_sent_at = Time.now
    end
  end
end
