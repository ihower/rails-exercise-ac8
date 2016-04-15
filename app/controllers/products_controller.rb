class ProductsController < ApplicationController

  def index
    @products = Product.page( params[:id] )
  end

  def show
    @product = Product.find( params[:id] )
  end
  
end
