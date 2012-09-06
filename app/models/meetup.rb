class Meetup < ActiveRecord::Base
  attr_accessible :topic, :description, :place, :date_and_time, :questions_attributes, :letter_subject, :letter_body,
                  :url, :premoderation

  has_many :participants
  has_many :questions
  has_many :articles

  accepts_nested_attributes_for :questions, :allow_destroy => true

  validates :topic, :presence => true
  validates :topic, :length => {:maximum => 255}
  validates :description, :presence => true
  validates :description, :length => {:maximum => 500}
  validates :place, :presence => true
  validates :place, :length => {:maximum => 255}
  validates :date_and_time, :presence => true
  validates_acceptance_of :date_and_time, :if => Proc.new { |meetup| meetup.date_and_time && meetup.date_and_time.past? }, :message => I18n.t('meetup.datetime_must_future')
  validates :letter_subject, :presence => true
  validates :letter_body, :presence => true

  scope :active, lambda { where('date_and_time > ? AND cancelled = ?', Time.new, false) }
  scope :recent, order('date_and_time')

  def participant?(user)
    self.participants.where('user_id = ?', user.id).present? if user
  end

  def active?
    self.date_and_time > Time.new && !self.cancelled
  end
end
