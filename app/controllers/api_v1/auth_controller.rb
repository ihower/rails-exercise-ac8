class ApiV1::AuthController < ApiController

  before_action :authenticate_user!, :only => [:logout]

  def login
    user = User.find_by_email( params[:email] )

    if user && user.valid_password?( params[:password] )
      render :json => { :user_id => user.id,
                        :auth_token => user.authentication_token }
    else
      render :json => { :message => "email or password is not correct" }, :status => 401
    end

  end

  def logout
    user = current_user

    user.generate_authentication_token
    user.save!

    render :json => { :message => "ok" }
  end

end
