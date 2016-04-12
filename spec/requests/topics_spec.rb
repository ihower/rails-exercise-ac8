require 'rails_helper'

RSpec.describe "Topic", type: :request do
  describe "GET /topics/:id" do

    before do
      @topic = create_topic
    end

    it "should return Topic JSON" do
      get "/topics/#{@topic.id}.json"

      data = {
        "id" => @topic.id,
        "subject" => @topic.subject
      }

      expect(response).to have_http_status(200)
      expect( JSON.parse(response.body) ).to eq(data)
    end

  end
end
