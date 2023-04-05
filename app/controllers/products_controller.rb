class ProductsController < ApplicationController

	def index
    @category = Category.find_by(id: params[:category_id])
    @products = @category.products
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def search
    @products = Product.where("products.name LIKE ?", "%" + params[:q] + "%")
    render :index
  end

end
