class ProductsController < ApplicationController

  before_action :get_cart

  def index
    @products = Product.page( params[:id] )
  end

  def show
    @product = Product.find( params[:id] )
  end

  def buy
    @product = Product.find( params[:id] )

    line_item = @cart.line_items.find_by_product_id( @product.id )
    if line_item
      line_item.qty += 1
      line_item.save!
    else
      @cart.line_items.create!( :product => @product, :qty => 1 )
    end

    redirect_to :back
  end

  def cancel
    @product = Product.find( params[:id] )
    line_item = @cart.line_items.find_by_product_id( @product.id )
    line_item.destroy

    redirect_to :back
  end

end
