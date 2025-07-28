class ReplyLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reply

  def create
    @reply.reply_likes.create(user: current_user)
    redirect_back fallback_location: community_topic_path(@reply.topic.community, @reply.topic)
  end

  def destroy
    like = @reply.reply_likes.find_by(user: current_user)
    like&.destroy
    redirect_back fallback_location: community_topic_path(@reply.topic.community, @reply.topic)
  end

  private

  def set_reply
    @reply = Reply.find(params[:reply_id])
  end
end
