class AddDeclineEmailSubjectDeclineEmailBodyAcceptEmailSubjectAcceptEmailBodyToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :decline_email_subject, :string
    add_column :meetups, :decline_email_body, :text
    add_column :meetups, :accept_email_subject, :string
    add_column :meetups, :accept_email_body, :text
  end
end
