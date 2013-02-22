class ChangeDataTypeForParticipantsAccepted < ActiveRecord::Migration
  def up
    change_table :participants do |t|
      t.change :accepted, :tinyint, :default => 2
    end
  end

  def down
    change_table :participants do |t|
      t.change :accepted, :boolean
    end
  end
end
