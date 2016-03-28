class TopicsController < ApplicationController

  def index
    @topics = Topic.page( params[:page] )
  end

  def show
    @topic = Topic.find( params[:id] )
  end

end
