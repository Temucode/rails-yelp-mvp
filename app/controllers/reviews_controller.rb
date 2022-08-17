class ReviewsController < ApplicationController
  before_action :set_restaurant, only: %i[new create]

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    # We need @restaurant in our `simple_form_for`
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.restaurant = @restaurant
    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @review = review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params) # Will raise ActiveModel::ForbiddenAttributesError
    redirect_to review_path(@review)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to restaurant_path(@review.restaurant), status: :see_other
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end

  # def review_params
  #   params.require(:review).permit(:rating, :content)
  # end
end
