require 'rails_helper'

RSpec.describe User, type: :model do

  describe ".display_name" do
    it "should return email first part" do
      user = create_user
      expect( user.display_name ).to eq("test")
    end
  end

  describe ".like_topic" do

    before do
      @user =create_user
      @topic = create_topic
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
