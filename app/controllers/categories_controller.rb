class CategoriesController < ApplicationController
  before_action :check_blocked_user
  before_action :authenticate_user!

  def index
    @categories = Category.order(:name)
  end

  def search
    @categories = Category.where("categories.name LIKE ?", "%" + params[:q] + "%")
    @products = Product.where("products.name LIKE ?", "%" + params[:q] + "%")
    render :index
  end
  
  private

  def check_blocked_user
    if current_user.present? && current_user.blocked?
      sign_out current_user
      flash[:notice] = "Your account has been blocked."
    end
  end

end
