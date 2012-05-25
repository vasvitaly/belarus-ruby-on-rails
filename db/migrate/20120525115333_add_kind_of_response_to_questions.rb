class AddKindOfResponseToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :kind_of_response, :integer
  end
end
