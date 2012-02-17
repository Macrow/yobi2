class ArticleImage < ActiveRecord::Base
  belongs_to :article
  mount_uploader :image, SlideImageUploader
  validates_presence_of :image
  
  before_save :update_major
  
  default_scope order("created_at DESC")
  
  private
  def update_major
    if self.article.major_image.nil?
      self.is_major = true
    end
  end  
end
