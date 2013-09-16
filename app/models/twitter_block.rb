class TwitterBlock < ActiveRecord::Base
  attr_accessible :widget, :title
  validates_presence_of :widget, :title
end
