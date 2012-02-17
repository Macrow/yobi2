module Admin
  class CategoryImagesController < BaseController
    defaults :resource_class => CategoryImage, :collection_name => 'images', :instance_name => 'image'
    belongs_to :category, :optional => true
    actions :index, :create, :update, :destroy
    respond_to :js
    
    def index
      index! { @images = CategoryImage.includes(:category).all }
    end

    def update
      @category = Category.includes(:major_image).find(params[:category_id])
      @image = CategoryImage.find(params[:id])
      @orgin_major_image = @category.major_image
      @orgin_major_image.update_attribute(:is_major, false) unless @orgin_major_image.nil?
      @image.update_attributes(params[:image])
      update!
    end
    
    def destroy
      destroy! { admin_cimages_path }
    end
  end
end
