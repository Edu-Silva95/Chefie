class RecipesController < ApplicationController
  before_action :authenticate_user!

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "Recipe created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    if params[:query].present?
      @recipes = Recipe.includes(:user)
                      .where("title ILIKE :q OR description ILIKE :q", q: "%#{params[:query]}%")
                      .order(created_at: :desc)
                      .page(params[:page])
                      .per(12)
    else
      @recipes = Recipe.includes(:user)
                      .order(created_at: :desc)
                      .page(params[:page])
                      .per(12)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    if user_signed_in?
      user_rating = @recipe.ratings.find_by(user: current_user)
      @user_rating = user_rating&.value
    else
      @user_rating = nil
    end
  end


  def new
    @recipe = Recipe.new
  end

  def edit
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :description, :ingredients, :instructions, :prep_time, :category, :image)
  end
end
