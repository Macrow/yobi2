module Admin
  class ArticlesController < BaseController
    actions :all
    before_filter :get_tags, :only => [:new, :create, :edit, :update]
    before_filter :initial_search, :only => [:index]
    
    def index
      index! { @articles = @search.all }
    end
    
    def toggle_elite
      @article = Article.find(params[:id])
      @article.update_attribute(:is_elite, !@article.is_elite)
      redirect_to :action =>  :index
    end
    
    private
    def get_tags
      article_tags = Article.tag_counts_on(:tags).all
      product_tags = Product.tag_counts_on(:tags).all
      @tags = (article_tags + product_tags).uniq
    end
    
    def initial_search
      @search = Article.search(params[:search])
    end
  end
end