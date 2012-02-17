class HomeController < ApplicationController
  before_filter :get_tags, :only => [:tags, :search]
  
  def index
    @lastest_article = Article.first
    @contact_article = Article.tagged_with("contacts", :any => true).first
    @elite_products = Product.includes(:major_image).where(:is_elite => true).limit(5)#.where(:category => "")
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
