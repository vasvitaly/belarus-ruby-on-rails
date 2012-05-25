class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :participant_id
      t.integer :question_id
      t.string :answer

      t.timestamps
    end
  end
end
