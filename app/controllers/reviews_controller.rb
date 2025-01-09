class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build(review_params)
      if @review.save
        redirect_to restaurant_path(@restaurant), status: :see_other
      else
        render :new, status: :unprocessable_entity
      end
    end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    @review.update(review_params)
    redirect_to restaurant_path(@restaurant), notice: "Review was successfully removed"
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy!
    redirect_to restaurant_path(@restaurant), notice: "Review was successfully removed"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @restaurant = Restaurant.find(params[:restaurant_id])
      @review = @restaurant.reviews.find(params.expect(:id))
    end

    def review_params
      params.require(:review).permit(:rating, :content, :restaurant_id)
    end
end
