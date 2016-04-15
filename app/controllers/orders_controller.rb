class OrdersController < ApplicationController

  before_action :get_cart

  def new
    @order = Order.new
  end

  def create
    @order = Order.new( order_params )

    @cart.line_items.each do |line|
      @order.line_items.build( :product => line.product, :qty => line.qty )
    end

    amount = 0
    @cart.line_items.each do |line|
      amount +=  line.product.price * line.qty
    end
    @order.amount = amount

    if @order.save

      session[:cart_id] = nil

      redirect_to products_path
    else
      render :new
    end
  end

  protected

  def order_params
    params.require(:order).permit(:name, :email)
  end

end
