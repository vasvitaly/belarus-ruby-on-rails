class AddPremoderationToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :premoderation, :boolean, :default => false
  end
end
