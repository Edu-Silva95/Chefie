class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites.includes(:recipe)
  end
  
  def create
    @favorite = current_user.favorites.build(recipe_id: params[:recipe_id])
    if @favorite.save
      redirect_back fallback_location: recipes_path, notice: "Added to favorites!"
    else
      redirect_back fallback_location: recipes_path, alert: @favorite.errors.full_messages.to_sentence
    end
  end


  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy
    redirect_back fallback_location: recipes_path, notice: "Removed from favorites!"
  end
end
