class AddAcceptedToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :accepted, :boolean, :default => true
  end
end
