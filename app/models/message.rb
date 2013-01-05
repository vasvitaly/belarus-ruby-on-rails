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

  class << self
    def deliver(recipient_group, subject, body, reversed, accepted)
      list_of_recipients(recipient_group, reversed, accepted).each do |recipient|
        Notifier.delay.broadcast_message(recipient.user.email, subject, body)
      end
    end
    handle_asynchronously :deliver

    def list_of_recipients(recipient_group, reversed, accepted)
      if reversed == "yes"
        if recipient_group
          Profile.subscribed.accepted(accepted).includes(:user).uniq - Profile.subscribed.accepted(accepted).filter(recipient_group).includes(:user).uniq
        else
          Profile.subscribed.accepted(accepted).includes(:user).uniq
        end
      else
        Profile.subscribed.accepted(accepted).filter(recipient_group).includes(:user).uniq
      end
    end
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
