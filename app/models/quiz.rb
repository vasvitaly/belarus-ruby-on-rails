class Quiz < ActiveRecord::Base
  attr_accessible :question, :answer, :question_id
  serialize :answer
  belongs_to :participant
  belongs_to :question
  validates :answer, :presence => true
  validate :one_answer_must_be_checked

  private
  def one_answer_must_be_checked
     errors.add(:answer, I18n.t("meetup.nothing_selected")) if
     self.answer.class == Array && (self.answer - [""]).blank?
  end

end
