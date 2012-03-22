class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  validates :title, :length => {:maximum => 255}
  validates :title, :presence => true
  validates :content, :presence => true
  has_many :comments, :order => "created_at ASC", :dependent => :delete_all

  belongs_to :user
  validates_associated :user
  attr_protected :user_id
  scope :published, where(:published => true)
  scope :internal, where('rss_link IS NULL')

  def normalize_friendly_id(text)
    text.to_slug.normalize! :transliterations => :russian if text
  end
end