class Topic < ActiveRecord::Base

  validates_presence_of :subject
  
  belongs_to :user
  has_many :comments

end
