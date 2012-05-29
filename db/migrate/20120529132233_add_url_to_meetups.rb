class AddUrlToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :url, :string
  end
end
