require 'rails_helper'

RSpec.describe User, type: :model do

  describe ".display_name" do
    it "should return email first part" do
      user = User.new( :email => "ihover@gmail.com" )
      expect( user.display_name ).to eq("ihover")
    end
  end

  describe ".like_topic" do

    before do
      @user = User.create!( :email => "test@example.com", :password => "12345678")
      @topic = Topic.create!( :subject => "FOOBAR")
    end

    it "should like topic" do
      @user.like_topic(@topic)

      like = Like.last
      expect(like.user).to eq(@user)
      expect(like.topic).to eq(@topic)

      expect(Like.count).to eq(1)
    end

    it "should not like twice" do
      @user.like_topic(@topic)
      @user.like_topic(@topic)

      expect(Like.count).to eq(1)
    end
  end



end
