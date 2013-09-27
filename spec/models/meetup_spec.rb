require 'spec_helper'

describe Meetup do
  subject { Meetup.new }

  it { should have_many(:participants) }
  it { should have_many(:questions) }
  it { should have_many(:articles) }
  it { should validate_presence_of(:date_and_time) }
  it { should validate_presence_of(:finish_date_and_time) }
  it { should have_db_column(:status).of_type(:boolean)
                              .with_options(default: true) }

  describe "create valid icalendar" do
  	let(:ical) { File.open(File.join(Rails.root, 'spec', 'fixtures', 'meetup.ics')).read }
  	let!(:exported_ical) {
      meetup = FactoryGirl.build(:meetup_ical)
      meetup.save(:validate => false)
      meetup.export_to_ics
    }

    it "create right parametrs" do
      exported_ical.lines.find_index(4).should eq ical.lines.find_index(4)
      exported_ical.lines.find_index(6).should eq ical.lines.find_index(6)
      exported_ical.lines.find_index(7).should eq ical.lines.find_index(7)
    end
  end
end
