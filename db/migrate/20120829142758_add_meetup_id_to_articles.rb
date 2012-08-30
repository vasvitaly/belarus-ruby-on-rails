class AddMeetupIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :meetup_id, :integer
  end
end
