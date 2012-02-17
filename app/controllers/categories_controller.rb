class CategoriesController < ApplicationController
  WillPaginate.per_page = 16
  before_filter :get_tags
  
  def index
    @categories = Category.includes(:major_image).roots
    @banner_image = "banner-pic-categories.jpg"
  end
  
  def show
    @category = Category.includes(:products).find_by_url(params[:url])
    raise ActiveRecord::RecordNotFound if @category.nil?
    @products = @category.products.page(params[:page])
    @banner_image = @category.display_image
    @elite_products = Product.limit(3)
  end
end
