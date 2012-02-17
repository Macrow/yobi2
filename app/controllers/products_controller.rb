class ProductsController < ApplicationController
  before_filter :get_tags
  
  def show
    @product = Product.includes(:category).find_by_url(params[:url])
    raise ActiveRecord::RecordNotFound if @product.nil?
    @category = @product.category
    @related_products = @product.find_related_tags.limit(5).all
    @related_articles = Article.tagged_with(@product.tags, :any => true).limit(5)
  end
end
