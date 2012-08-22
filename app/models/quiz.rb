class Quiz < ActiveRecord::Base
  attr_accessible :question, :answer, :question_id
  serialize :answer
  belongs_to :participant
  belongs_to :question
  validate :answer_presence
  validate :one_answer_must_be_checked

  private
  def one_answer_must_be_checked
     errors.add(:answer, I18n.t("meetup.nothing_selected")) if
     self.answer.class == Array && (self.answer - [""]).blank?
  end

  def answer_presence
    if self.answer.class != Array && self.answer.blank? && self.question.required
      errors.add(:answer, I18n.t("meetup.can_not_be_blank"))
    end
  end

end
