class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :content
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
