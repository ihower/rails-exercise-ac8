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
    @cart.add_product( @product )

    redirect_to :back
  end

  def cancel
    @product = Product.find( params[:id] )
    @cart.remove_product(@product)

    redirect_to :back
  end

end
