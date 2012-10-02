class AddMinLengthLengthMaxLengthToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :min_length, :integer
    add_column :questions, :length, :integer
    add_column :questions, :max_length, :integer
  end
end
