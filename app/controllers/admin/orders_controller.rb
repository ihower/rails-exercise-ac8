class Admin::OrdersController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin

  def index
    @orders = Order.page(params[:page])
  end
  
end
