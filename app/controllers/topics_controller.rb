class TopicsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_my_topic, :only => [:edit, :update, :destroy]

  def index
    @topics = Topic.order("id DESC").page( params[:page] )
  end

  def show
    @topic = Topic.find( params[:id] )
    @comment = Comment.new
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

  def edit
      end

  def update

    if params[:destory_image]
      @topic.image = nil
    end

    if @topic.update( topic_params )
      redirect_to topic_url(@topic)
    else
      render "edit"
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_url
  end

  protected

  def topic_params
    params.require(:topic).permit(:content, :subject, :image)
  end

  def set_my_topic
    @topic = current_user.topics.find( params[:id])
  end

end
