class Order < ActiveRecord::Base

  has_many :line_items
  has_many :products, :through => :line_items
  
end
