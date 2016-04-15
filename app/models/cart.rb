class Cart < ActiveRecord::Base

  has_many :line_items
  has_many :products, :through => :line_items

  def add_product(product, qty)
    line_item = self.line_items.find_by_product_id( product.id )
    if line_item
      line_item.qty += qty
      line_item.save!
    else
      self.line_items.create!( :product => product, :qty => qty )
    end
  end

  def remove_product(product)
    line_item = self.line_items.find_by_product_id( product.id )
    line_item.destroy
  end

  def total
    self.line_items.map{ |l| l.qty }.sum
  end

  def amount
    amount = 0
    self.line_items.each do |line|
      amount +=  line.product.price * line.qty
    end

    return amount
  end

end
