class OrdersController < ApplicationController

  before_action :authenticate_user!
  before_action :get_cart

  def new
    @order = Order.new

    if current_user
      @order.name = current_user.display_name
      @order.email = current_user.email
    end
  end

  def create
    @order = Order.new( order_params )
    @order.user = current_user

    @order.clone_cart_line_items(@cart)

    @order.amount = @cart.amount

    if @order.save

      cookies[:cart_id] = nil

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
