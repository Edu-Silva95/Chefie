class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ratable

  def create
    @rating = Rating.find_or_initialize_by(user: current_user, ratable: @ratable)
    @rating.assign_attributes(rating_params)

    if @rating.save
      redirect_to @ratable, notice: "Rating submitted!"
    else
      redirect_to @ratable, alert: @rating.errors.full_messages.to_sentence
    end
  end

  private

  def set_ratable
    if params[:recipe_id]
      @ratable = Recipe.find(params[:recipe_id])
    elsif params[:course_id]
      @ratable = Course.find(params[:course_id])
    else
      raise "No ratable found"
    end
  end


  def rating_params
    params.require(:rating).permit(:value)
  end
end
