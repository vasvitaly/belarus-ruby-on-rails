class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :custom_news

      t.string :author
      t.text :body

      t.timestamps
    end
  end
end
