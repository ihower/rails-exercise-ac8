class LikesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_topic

  def create
    like = @topic.finy_like_by(current_user)
    if like
      # do nothing
    else
      @topic.likes.create!( :user => current_user )
    end

    redirect_to :back
  end

  def destroy
    @like = current_user.likes.find( params[:id] )
    @like.destroy

    redirect_to :back
  end

  protected

  def set_topic
    @topic = Topic.find( params[:topic_id] )
  end

end
