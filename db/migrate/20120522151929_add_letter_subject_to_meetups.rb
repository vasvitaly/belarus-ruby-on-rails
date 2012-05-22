class AddLetterSubjectToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :letter_subject, :string
    add_column :meetups, :letter_body, :text
  end
end
