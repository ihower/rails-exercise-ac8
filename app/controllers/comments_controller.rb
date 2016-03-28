class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_topic

  def create
    @comment = @topic.comments.new( comment_params )
    @comment.user = current_user
    
    if @comment.save
      redirect_to topic_url(@topic)
    else
      render "topics/show"
    end
  end

  protected

  def set_topic
    @topic = Topic.find( params[:topic_id] )
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
