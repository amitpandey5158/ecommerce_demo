class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.order(:name)
  end

  def search
    @categories = Category.where("categories.name LIKE ?", "%" + params[:q] + "%")
    @products = Product.where("products.name LIKE ?", "%" + params[:q] + "%")
    render :index
  end
  
end
