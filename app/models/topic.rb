class Topic < ActiveRecord::Base

  STATUS = ["draft", "published", "scheduled"]

  validates_presence_of :subject

  belongs_to :user
  belongs_to :category

  has_many :comments

  has_many :likes
  has_many :like_users, :through => :likes, :source => :user

  has_many :subscriptions
  has_many :subscribed_users, :through => :likes, :source => :user

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def finy_like_by(user)
    user && self.likes.find_by_user_id( user.id )
  end

  def finy_subscription_by(user)
    user && self.subscriptions.find_by_user_id( user.id )
  end

end
