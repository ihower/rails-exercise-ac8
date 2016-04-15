class Order < ActiveRecord::Base

  belongs_to :user

  has_many :line_items
  has_many :products, :through => :line_items

  def clone_cart_line_items(cart)
    cart.line_items.each do |line|
      self.line_items.build( :product => line.product, :qty => line.qty )
    end
  end

end
