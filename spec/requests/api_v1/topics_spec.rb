require 'rails_helper'

RSpec.describe "Topic", type: :request do
  before do
    @topic = create_topic
  end

  describe "GET /api/v1/topics/:id" do
    it "should return Topic JSON" do
      get "/api/v1/topics/#{@topic.id}"

      data = {
        "id" => @topic.id,
        "subject" => @topic.subject,
        "content" => @topic.content,
        "user_id" => @topic.user_id,
        "created_at" => @topic.created_at.as_json,
        "updated_at" => @topic.updated_at.as_json
      }

      expect(response).to have_http_status(200)
      expect( JSON.parse(response.body) ).to eq(data)
    end
  end

  describe "GET /api/v1/topics" do
    it "should return Topics JSON" do
      get "/api/v1/topics"

      data = {
        "meta"=>{
          "current_page"=>1,
          "total_pages"=>1,
          "per_page"=>25,
          "next_url"=>nil,
          "previous_url"=>nil},
        "results"=>[{
          "id" => @topic.id,
          "subject" => @topic.subject,
          "content" => @topic.content,
          "user_id" => @topic.user_id,
          "created_at" => @topic.created_at.as_json,
          "updated_at" => @topic.updated_at.as_json
        }]
      }

      expect(response).to have_http_status(200)
      expect( JSON.parse(response.body) ).to eq(data)
    end
  end

  describe "POST /api/v1/topics" do
    it "should return errors" do
      post "/api/v1/topics"

      expect(response).to have_http_status(400)
    end

    it "should return topic id" do
      post "/api/v1/topics", :subject => "foo", :content => "bar"

      expect(response).to have_http_status(200)
      parsed_data = JSON.parse( response.body )
      topic = Topic.last
      expect(parsed_data).to eq( { "id" => topic.id } )
      expect(topic.subject).to eq("foo")
      expect(topic.content).to eq("bar")
    end
  end

end
