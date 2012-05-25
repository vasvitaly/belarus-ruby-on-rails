class Answer < ActiveRecord::Base
  attr_accessible :gist
  belongs_to :question
  validates :gist, :presence => true
end
