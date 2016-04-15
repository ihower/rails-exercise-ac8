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

    if params[:qty]
      qty = params[:qty].to_i
    else
      qty = 1
    end

    @cart.add_product( @product, qty )

    respond_to do |format|
      format.html { redirect_to :back }
      format.js # buy.js.erb
    end
  end

  def cancel
    @product = Product.find( params[:id] )
    @cart.remove_product(@product)

    redirect_to :back
  end

end
