class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_course, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @courses = Course.all
    @posts = Post.order(created_at: :desc).limit(10)
    @courses = Course.order(created_at: :desc) # Fetch courses in descending order of creation
  end

  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      redirect_to courses_path, notice: "Course added successfully."
    else
      flash.now[:alert] = @course.errors.full_messages.to_sentence
      @courses = Course.all.includes(:user)
      @posts = Post.order(created_at: :desc).limit(10)
      render :index, status: :unprocessable_entity
    end
  end

  def show_all
    if params[:search].present?
      @courses = Course.where("LOWER(TRIM(name)) LIKE ?", "%#{params[:search].strip.downcase}%")
    else
      @courses = Course.all.order(created_at: :desc)
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to courses_path, notice: "Course updated successfully."
    else
      flash.now[:alert] = "Failed to update course."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path, notice: "Course deleted."
  end

  def show
    @course = Course.find(params[:id])
    user_rating = Rating.find_by(user: current_user, ratable: @course)
    @user_rating = user_rating&.value
    @user = @course.user
    @courses = Course.where(user: @user).order(created_at: :desc)
    @favorite = current_user.favorites.find_by(course: @course) if user_signed_in?
  end


  def like
    if current_user.likes.create(likeable: @course)
      redirect_to courses_path, notice: "You liked this course!"
    else
      redirect_to courses_path, alert: "Unable to like this course."
    end
  end

  def unlike
    like = current_user.likes.find_by(likeable: @course)
    if like&.destroy
      redirect_to courses_path, notice: "You unliked this course."
    else
      redirect_to courses_path, alert: "Unable to unlike this course."
    end
  end


  private

  def set_course
    @course = Course.find(params[:id])
  end

  def authorize_user!
    redirect_to courses_path, alert: "Not authorized" unless @course.user == current_user
  end

  def course_params
    params.require(:course).permit(:description, :name, :youtube_url, :image)
  end
end
