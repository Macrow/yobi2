#encoding: utf-8
class HomeController < ApplicationController
  # caches_page :index
  before_filter :get_tags, :only => [:tags, :search]
  
  def index
    @lastest_article = Article.first
    @contact_article = Article.find_by_url("contact")
    @model_article = Article.find_by_url("model-customers")
    @elite_products_1 = Product.includes(:major_image).where(:is_elite => true).limit(5).where(:category_id => 7)
    @elite_products_2 = Product.includes(:major_image).where(:is_elite => true).limit(5).where(:category_id => [4, 5])
    @elite_products_3 = Product.includes(:major_image).where(:is_elite => true).limit(5).where(:category_id => [6, 11])
    @elite_products_4 = Product.includes(:major_image).where(:is_elite => true).limit(5).where(:category_id => [13, 14])
    @slides = Slide.where(:is_hide => false).limit(6)
  end
  
  def search
    unless params[:search][:name_contains].empty?
      @search = Product.search(params[:search])
      @products = @search.includes(:major_image)
    end
  end
  
  def tags
    articles = Article.tagged_with(CGI::unescape(params[:tag])).all
    products = Product.tagged_with(CGI::unescape(params[:tag])).includes(:major_image).all
    @items = (articles + products).sort_by(&:updated_at)
  end
end
