require 'rails_helper'

RSpec.describe "Auth", type: :request do
  before do
    @user = create_user
  end

  describe "facebook" do
    it "should login by facebook access_token (not existing)" do
      fb_data = {
        "id" => "5678",
        "email" => "bar@example.org",
        "name" => "ihower"
      }

      expect(User).to receive(:get_fb_data).with("fb-token-xxxx").and_return(fb_data)

      post "/api/v1/login", :access_token => "fb-token-xxxx"

      expect(response).to have_http_status(200)

      user = User.last

      data = {
        "auth_token" => user.authentication_token,
        "user_id" => user.id
      }

      expect(JSON.parse(response.body)).to eq(data)
    end

    it "should login by facebook access_token (existing)" do
      fb_data = {
        "id" => "1234",
        "email" => @user.email,
        "name" => "ihower"
      }

      expect(User).to receive(:get_fb_data).with("fb-token-xxxx").and_return(fb_data)

      post "/api/v1/login", :access_token => "fb-token-xxxx"

      expect(response).to have_http_status(200)

      data = {
        "auth_token" => @user.authentication_token,
        "user_id" => @user.id
      }

      expect(JSON.parse(response.body)).to eq(data)
    end

    it "should login failed" do
      expect(User).to receive(:get_fb_data).with("qq").and_return(nil)

      post "/api/v1/login", :access_token => "qq"

      expect(response).to have_http_status(401)
    end

  end

  describe "POST /api/v1/login" do
    it "should be error if email or password is wrong" do
      post "/api/v1/login"

      data = {
        "message" => "email or password is not correct"
      }
      expect(response).to have_http_status(401)
      expect( JSON.parse(response.body) ).to eq(data)
    end

    it "should return token if email and password are correct" do
      post "/api/v1/login", :email => @user.email, :password => "12345678"

      data = {
        "user_id" => @user.id,
        "auth_token" => @user.authentication_token
      }
      expect(response).to have_http_status(200)
      expect( JSON.parse(response.body) ).to eq(data)
    end

  end

  describe "POST /api/v1/logout" do
    it "should reset authentication_token" do
      old_auth_token = @user.authentication_token
      post "/api/v1/logout", :auth_token => @user.authentication_token

      expect(response).to have_http_status(200)

      @user.reload

      expect(@user.authentication_token).to_not eq( old_auth_token )
    end

    it "should return 401 if token is wrong" do
      post "/api/v1/logout", :auth_token => "ooxx"

      expect(response).to have_http_status(401)
    end
  end


end
