class CategoryImage < ActiveRecord::Base
  belongs_to :category
  mount_uploader :image, CategoryImageUploader
  validates_presence_of :image
  
  before_save :update_major
  
  default_scope order("created_at DESC")
  
  private
  def update_major
    if self.category.major_image.nil?
      self.is_major = true
    end
  end  
end
