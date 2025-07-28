class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @video_count = Course.count
    @recipe_count = Recipe.count
  end
end
