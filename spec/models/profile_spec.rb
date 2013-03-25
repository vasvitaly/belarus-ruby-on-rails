require 'spec_helper'

describe Profile do
  it "should be valid" do
    profile = FactoryGirl.build(:profile)
    profile.should be_valid
  end

  it "should not be valid without first name" do
    profile = FactoryGirl.build(:profile, :first_name => "")
    profile.should have(1).error_on(:first_name)
  end

  it "should not be valid without last name" do
    profile = FactoryGirl.build(:profile, :last_name => "")
    profile.should have(1).error_on(:last_name)
  end

  it "should not be valid if first name is longer than 255 symbols" do
    profile = FactoryGirl.build(:profile, :first_name => "a" * 256)
    profile.should have(1).error_on(:first_name)
  end

  it "should not be valid if last name is longer than 255 symbols" do
    profile = FactoryGirl.build(:profile, :last_name => "a" * 256)
    profile.should have(1).error_on(:last_name)
  end

  it { should respond_to(:subscribed) }

  it "has a Ruby experience level" do
    profile = FactoryGirl.create(:profile, :subscribed => true, :experience => FactoryGirl.create(:experience))
    profile.experience.should_not be_nil
  end

  it "should set Ruby on Rails experience level if subscribed" do
    profile = FactoryGirl.build(:profile, :experience => nil)
    profile.should have(1).error_on(:experience_id)
  end

  it { should have_attached_file(:avatar) }
  it { should validate_attachment_content_type(:avatar).
              allowing('image/png', 'image/gif', 'image/jpg').
              rejecting('text/plain', 'text/xml') }

  context '.subscribed.participants_on' do
    before(:each) do
      @meetup = FactoryGirl.create(:meetup)
      @meetup_second = FactoryGirl.create(:meetup, :date_and_time => Time.now + 1.week)
      @user_subscribed = FactoryGirl.create(:user, :profile => FactoryGirl.create(:profile,
                                                    :subscribed => true,
                                                    :experience => FactoryGirl.create(:experience)))
      @user_unsubscribed = FactoryGirl.create(:user)
      @admin = FactoryGirl.create(:user, :is_admin => true, :profile => FactoryGirl.create(:profile,
                                                    :subscribed => true,
                                                    :experience => FactoryGirl.create(:experience)))

      @user_subscribed.participants.create(:meetup_id => @meetup.id)
      @user_subscribed.participants.create(:meetup_id => @meetup_second.id)

      @user_unsubscribed.participants.create(:meetup_id => @meetup.id)

      @admin.participants.create(:meetup_id => @meetup.id)
      @admin.participants.create(:meetup_id => @meetup_second.id)

      @participants = Profile.subscribed.participants_on(@meetup.id.to_s)
    end

    it "contains email of subscribed user" do
      @participants.should include(@user_subscribed.profile)
    end

    it "does not contain email of unsubscribed user" do
      @participants.should_not include(@user_unsubscribed.profile)
    end

    it "contain email of admin" do
      @participants.should include(@admin.profile)
    end

    it "does not contain duplicate" do
      @participants.uniq!.should be_nil
    end
  end
end
