class ArticlesController < ApplicationController
  before_filter :get_tags
  
  def index
    @articles = Article.page(params[:page])
    @lastest_articles = Article.limit(3)
  end
  
  def show
    @article = Article.find_by_url(params[:url])
    raise ActiveRecord::RecordNotFound if @article.nil?
    @banner_image = @article.display_image
    @lastest_articles = Article.limit(3)
  end
end
