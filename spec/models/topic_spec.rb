require 'rails_helper'

RSpec.describe Topic, type: :model do

  before do
    @user = User.create!( :email => "test@example.com", :password => "12345678")
    @topic = Topic.create!( :subject => "FOOBAR")
  end

  describe ".finy_like_by" do
    it "should return like by user" do
      test_like = @user.like_topic(@topic)

      found_like = @topic.finy_like_by( @user )

      expect(found_like).to eq( test_like )
    end

    it "should return nil if not found" do
      like = @topic.finy_like_by( @user )
      expect( like ).to eq(nil)
    end

    it "should return nil if user is nil" do
      like = @topic.finy_like_by(nil)
      expect( like ).to eq(nil)
    end

  end


end
