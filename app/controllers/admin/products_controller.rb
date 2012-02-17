module Admin
  class ProductsController < BaseController
    before_filter :get_categories_and_plists, :only => [:new, :edit, :create, :update]
    before_filter :get_tags, :only => [:new, :create, :edit, :update]
    before_filter :initial_search, :only => [:index]
    
    actions :all
    
    def index
      index! { @products = @search.includes(:category).page(params[:page]) }
    end
    
    def edit
      edit! { @product = Product.includes(:tags).find(params[:id]) }
    end
    
    def destroy_confirm
      @product = Product.includes(:properties, :images).find(params[:id])
    end
    
    private
    
    def get_categories_and_plists
      @categories = Category.get_categories_tree
      @plists = Plist.all.collect(&:name)
    end
    
    def get_tags
      article_tags = Article.tag_counts_on(:tags).all
      product_tags = Product.tag_counts_on(:tags).all
      @tags = (article_tags + product_tags).uniq
    end
    
    def initial_search
      @search = Product.search(params[:search])
    end
  end
end