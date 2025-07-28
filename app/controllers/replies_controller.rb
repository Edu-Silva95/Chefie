class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic

  def create
    @reply = @topic.replies.new(reply_params)
    @reply.user = current_user

    if @reply.save
      redirect_to community_topic_path(@topic.community, @topic), notice: "Reply added."
    else
      @replies = @topic.replies.order(created_at: :asc)
      render "topics/show"
    end
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def reply_params
    params.require(:reply).permit(:content)
  end
end
