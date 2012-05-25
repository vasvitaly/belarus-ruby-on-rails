class Question < ActiveRecord::Base
  RESPONSE_TYPES = %w(dropdown checkboxes text_field).freeze
  attr_accessible :answers_attributes, :gist
  belongs_to  :meetup
  has_many    :answers
  accepts_nested_attributes_for :answers

# TODO: fix required class in the styles.css for uncomment this line, because it is hidden now!
#  validates :gist, :presence => true

  def self.response_type_options_for_select
    RESPONSE_TYPES.map { |r| [human_attribute_name(r), RESPONSE_TYPES.index(r)] }
  end
end
