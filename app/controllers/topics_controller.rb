class TopicsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @topics = Topic.order("id DESC").page( params[:page] )
  end

  def show
    @topic = Topic.find( params[:id] )
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new( topic_params )
    @topic.user = current_user

    if @topic.save
      redirect_to topic_url(@topic)
    else
      render :new
    end
  end

  protected

  def topic_params
    params.require(:topic).permit(:content, :subject)
  end

end
