class Category < ActiveRecord::Base

  has_many :topics
  
end
