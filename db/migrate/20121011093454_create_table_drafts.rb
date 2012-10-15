class CreateTableDrafts < ActiveRecord::Migration
  def up
    create_table :drafts do |t|
      t.string :object_type, :null => false
      t.integer :object_id, :null => false
      t.string :draft_object
      t.timestamps
    end
    add_index :drafts, [:object_type, :object_id]
  end

  def down
    drop_table :drafts
  end
end
