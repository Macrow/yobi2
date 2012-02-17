class ProductImage < ActiveRecord::Base
  belongs_to :product
  mount_uploader :image, ProductImageUploader
  validates_presence_of :image
  
  before_save :update_major
  
  default_scope order("created_at DESC")
  
  private
  def update_major
    if self.product.major_image.nil?
      self.is_major = true
    end
  end
end
