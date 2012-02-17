class ApplicationController < ActionController::Base
  protect_from_forgery
  include CacheableFlash
  before_filter :initial_search, :get_products_categories
  WillPaginate.per_page = 10
  # rescue_from Exception, :with => :render_all_errors

  protected
  def get_tags
    article_tags = Article.tag_counts_on(:tags).all
    product_tags = Product.tag_counts_on(:tags).all
    @tags = (article_tags + product_tags).uniq
  end
  
  private
  def initial_search
    @search = Product.search(params[:search])
  end
  
  def get_products_categories
    @products_categories = Category.scoped.arrange(:order => :position)
  end
  
  def render_all_errors(e)
    if e.is_a?(ActionController::RoutingError) || e.is_a?(ActiveRecord::RecordNotFound)
      render_404_error(e)
    else
      # render_other_error(e)
    end
  end

  def render_404_error(e)
    render :file => "#{Rails.root}/public/404.html", :layout => false, :status => 404
  end
  
  def render_other_error(e)
    render :file => "#{Rails.root}/public/500.html", :layout => false, :status => 500
  end
end
