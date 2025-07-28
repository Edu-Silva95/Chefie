class TopicsController < ApplicationController
  before_action :set_community

  def new
    @community = Community.find(params[:community_id])
    @topic = @community.topics.new
  end

  def create
    @community = Community.find(params[:community_id])
    @topic = @community.topics.new(topic_params)
    @topic.user = current_user

    if @topic.save
      redirect_to community_path(@community), notice: "Topic created."
    else
      Rails.logger.debug "Topic errors: #{@topic.errors.full_messages.join(', ')}"
      @topics = @community.topics.order(created_at: :desc)
      respond_to do |format|
        format.html { render "communities/show", status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("topics_form", partial: "topics/form", locals: { community: @community, topic: @topic }) }
      end
    end
  end


  def show
    @topic   = @community.topics.find(params[:id])
    @replies = @topic.replies.order(created_at: :asc)
    @reply   = Reply.new
    @more_topics = @topic.user.topics.where.not(id: @topic.id).limit(4)
  end

  private

  def set_community
    @community = Community.find(params[:community_id])
  end

  def topic_params
    params.require(:topic).permit(:title, :content)
  end

end
