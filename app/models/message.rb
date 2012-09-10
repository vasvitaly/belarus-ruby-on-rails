class Message
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :recipient_group, :subject, :body, :reversed, :accepted

  validates_each :recipient_group do |model, attribute, values|
    filters = Meetup.all.map{ |el| el.id.to_s }
    model.errors.add attribute, I18n.t('admin.messages.invalid_user_group')  if values && values != (values & filters)
  end
  validates :subject, :presence=> true
  validates :body, :presence => true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end
