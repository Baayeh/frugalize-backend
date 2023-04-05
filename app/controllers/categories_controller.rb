class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show update destroy ]
  before_action :authenticate_user!

  # GET /categories
  def index
    categories = Category.all
    all_categories = []

    categories.each do |category|
      new_cat = CategorySerializer.new(category).serializable_hash[:data][:attributes]
      all_categories << new_cat
    end

    render json: all_categories
  end

  # GET /categories/1
  def show
    render json: @category
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    @category.user = current_user

    if @category.save
      render json: {
        message: 'Category was successfully created'
      }, status: :created
    else
      render json: {
        message: 'Category could not be created',
        errors: @category.errors
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :image)
    end
end
