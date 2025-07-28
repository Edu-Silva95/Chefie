class PostsController < ApplicationController
  before_action :authenticate_user!  # if you have authentication
  before_action :set_post,        only: [:destroy, :like, :unlike]
  before_action :authorize_user!, only: [:destroy]


  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_back fallback_location: courses_path, notice: "Your message has been published."
    else
      # Log or inspect errors:
      Rails.logger.debug "Post errors: #{@post.errors.full_messages.join(', ')}"
      redirect_back fallback_location: courses_path, alert: "Failed to publish your message: #{@post.errors.full_messages.join(', ')}"
    end
  end


  def destroy
    @post.destroy
    redirect_back fallback_location: courses_path, notice: "Post deleted."
  end

  def like
    @post = Post.find(params[:id])
    unless @post.likes.exists?(user: current_user)
      if current_user.likes.create(likeable: @post)
        redirect_back fallback_location: dashboard_path, notice: "You liked this post!"
      else
        redirect_back fallback_location: dashboard_path, alert: "Unable to like this post."
      end
    else
      redirect_back fallback_location: dashboard_path, alert: "You already liked this post."
    end
  end

  def unlike
    @post = Post.find(params[:id])
    like = current_user.likes.find_by(likeable: @post)
    if like&.destroy
      redirect_back fallback_location: dashboard_path, notice: "You unliked this post."
    else
      redirect_back fallback_location: dashboard_path, alert: "Unable to unlike this post."
    end
  end


  private

  def post_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    unless @post.user == current_user
      redirect_back fallback_location: courses_path, alert: "You can only delete your own posts."
    end
  end
end
