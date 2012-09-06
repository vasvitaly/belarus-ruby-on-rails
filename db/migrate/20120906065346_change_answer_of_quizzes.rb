class ChangeAnswerOfQuizzes < ActiveRecord::Migration
  def up
    change_column :quizzes, :answer, :text
  end

  def down
    change_column :quizzes, :answer, :string
  end
end
