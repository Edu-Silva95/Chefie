class CategoriesController < ApplicationController
  def show
    @category = params[:name]
    @recipes = Recipe.where(category: @category).order(created_at: :desc)
  end
end
