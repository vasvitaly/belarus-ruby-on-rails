class Video < ActiveRecord::Base
  attr_accessible :title, :description, :content
  validates_presence_of :title, :description, :content
end
