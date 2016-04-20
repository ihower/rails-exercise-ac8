class Pay2goController < ApplicationController
  skip_before_action :verify_authenticity_token

  def return
    result = nil
    ActiveRecord::Base.transaction do
      @payment = Payment.find_and_process( json_data )
      result = @payment.save
    end

    unless result
      flash[:alert] = "驗證碼錯誤"
    end

    @order = @payment.order

    if @payment.paid?
     # send paid email
    end

    redirect_to order_path(@order)
  end

  def notify
    result = nil
    ActiveRecord::Base.transaction do
      @payment = PaymentPay2go.find_and_process( json_data )
      result = @payment.save
    end

    if result
      render :text => "1|OK"
    else
      render :text => "0|ErrorMessage"
    end
  end

  private

  def json_data
    JSON.parse( params["JSONData"] )
  end

end
