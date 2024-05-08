class CategoriesController < ApplicationController
  def create
    category = Category.new(category_params)
    if category.save
      redirect_to category_groups_path(category.id)
    else
      redirect_to request.referer
    end
  end

  def index
    @categories = Category.all
    @category = Category.new
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
