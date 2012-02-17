module Admin
  class ArticleImagesController < BaseController
    defaults :resource_class => ArticleImage, :collection_name => 'images', :instance_name => 'image'
    belongs_to :article, :optional => true
    actions :index, :create, :update, :destroy
    respond_to :js
    
    def index
      index! { @images = ArticleImage.includes(:article).all }
    end

    def update
      @article = Article.includes(:major_image).find(params[:article_id])
      @image = ArticleImage.find(params[:id])
      @orgin_major_image = @article.major_image
      @orgin_major_image.update_attribute(:is_major, false) unless @orgin_major_image.nil?
      @image.update_attributes(params[:image])
      update!
    end
    
    def destroy
      destroy! { admin_aimages_path }
    end
  end
end
