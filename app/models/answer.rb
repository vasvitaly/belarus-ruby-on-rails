class Answer < ActiveRecord::Base
  attr_accessible :gist
  belongs_to :question
  # TODO: fix required class in the styles.css for uncomment this line, because it is hidden now!
  #  validates :gist, :presence => true
end
