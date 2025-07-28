class CommunitiesController < ApplicationController
  def index
    @communities = Community.order(:title)
  end

  def show
    @community = Community.find(params[:id])

    if params[:query].present?
      @topics = @community.topics
                .where("title ILIKE ?", "%#{params[:query]}%")
                .order(updated_at: :desc)
                .page(params[:page])
                .per(15)
      @search_query = params[:query]
    else
      @topics = @community.topics
                .order(updated_at: :desc)
                .page(params[:page])
                .per(15)
    end

    @topic = Topic.new
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params.merge(user: current_user))
    if @community.save
      redirect_to communities_path, notice: "Community created successfully."
    else
      render :new
    end
  end

  def search
    query = params[:query].to_s.strip
    @topics = Topic.where("title ILIKE ?", "%#{query}%").order(updated_at: :desc).page(params[:page]).per(15)
    render :search_results
  end

  private

  def community_params
    params.require(:community).permit(:title, :description)
  end
end
