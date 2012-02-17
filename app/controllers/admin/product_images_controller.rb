module Admin
  class ProductImagesController < BaseController
    defaults :resource_class => ProductImage, :collection_name => 'images', :instance_name => 'image'
    belongs_to :product, :optional => true
    actions :index, :create, :update, :destroy
    respond_to :js
    
    def index
      index! { @images = ProductImage.includes(:product).all }
    end

    def update
      @product = Product.includes(:major_image).find(params[:product_id])
      @image = ProductImage.find(params[:id])
      @orgin_major_image = @product.major_image
      @orgin_major_image.update_attribute(:is_major, false) unless @orgin_major_image.nil?
      @image.update_attributes(params[:image])
      update!
    end
    
    def destroy
      destroy! { admin_pimages_path }
    end
  end
end