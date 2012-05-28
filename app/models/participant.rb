class Participant < ActiveRecord::Base
  attr_accessible :user, :meetup, :quizzes_attributes
  belongs_to :user
  belongs_to :meetup
  has_many :quizzes

  accepts_nested_attributes_for :quizzes

  delegate :email, :to => :user

  validates :meetup_id, :user_id, :presence => true
  validates :user_id, :uniqueness => { :scope => :meetup_id }
  validates_associated :quizzes
end
