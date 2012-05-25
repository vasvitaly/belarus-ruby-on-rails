class Quiz < ActiveRecord::Base
  attr_accessible :question, :answer, :question_id
  serialize :answer
  belongs_to :participant
  belongs_to :question
end
