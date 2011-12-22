class ArticlesController < ApplicationController
  def show
    @article = Article.find_by_url(params[:url])
    raise ActiveRecord::RecordNotFound if @article.nil?
  end
end
