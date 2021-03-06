class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :set_timezone

  protected

  helper_method :current_cart

  def current_cart
    if @cart
      return @cart
    else
      if cookies.signed[:cart_id]
        @cart = Cart.find( cookies.signed[:cart_id] )
      else
        @cart = Cart.create
        cookies.permanent.signed[:cart_id] = @cart.id
      end
      return @cart
    end
  end

  def set_timezone
     if current_user && current_user.time_zone
        Time.zone = current_user.time_zone
      end
  end

  def set_locale
    # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

  def check_admin
    unless current_user.admin?
      flash[:alert] = "Nooooo~~~"
      redirect_to root_path
      return
    end
  end

end
