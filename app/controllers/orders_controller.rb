class OrdersController < ApplicationController

  before_action :authenticate_user!

  def show
    @order = current_user.orders.find( params[:id] )
  end

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

    @order.clone_cart_line_items(current_cart)

    @order.amount = current_cart.amount

    if @order.save
      cookies[:cart_id] = nil

      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def checkout_pay2go
   @order = current_user.orders.find(params[:id])

   if @order.paid?
     redirect_to :back, alert: 'already paid!'
   else
    @payment = Payment.create!( :order => @order,
                                :payment_method => params[:payment_method] )
    render :layout => false
   end
  end

  protected

  def order_params
    params.require(:order).permit(:name, :email)
  end

end
