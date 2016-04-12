require 'rails_helper'

RSpec.describe TopicsController, type: :controller do

  before do
    @user = create_user
    sign_in @user
  end

  describe "POST #create" do

    it "should create topic failed" do
      post :create, :topic => { :subject => "" }

      expect( Topic.count ).to eq(0)

      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end

    it "should create topic" do
      post :create, :topic => { :subject => "FOOBAR" }

      topic = Topic.last
      expect( Topic.count ).to eq(1)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to( topic_url(topic) )
    end

    it "should create topic (mock version)" do
      fake_topic = double(:topic)
      expect(Topic).to receive(:new).with( { :subject => "FOOBAR" } ).and_return(fake_topic)
      expect(fake_topic).to receive(:"user=")
      expect(fake_topic).to receive(:save).and_return(true)

      post :create, :topic => { :subject => "FOOBAR" }

      expect(response).to have_http_status(302)
      expect(response).to redirect_to( topic_url(fake_topic) )
    end
  end

end
