class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :gist
      t.belongs_to :meetup
      t.timestamps
    end
  end
end
