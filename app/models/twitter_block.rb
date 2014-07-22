class TwitterBlock < ActiveRecord::Base
  attr_accessible :widget, :title, :subject, :search, :footer_text
  validates_presence_of :widget, :title
end
