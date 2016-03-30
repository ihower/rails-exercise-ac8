class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_topic

  def create
    @comment = @topic.comments.new( comment_params )
    @comment.user = current_user

    if @comment.save

      respond_to do |format|
        format.html { redirect_to topic_url(@topic) }
        format.js # create.js.erb
      end

    else
      render "topics/show"
    end
  end

  def destroy
    @comment = current_user.comments.find( params[:id] )
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.js # destroy.js.erb
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
