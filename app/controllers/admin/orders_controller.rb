class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.page(params[:page])
  end

end
