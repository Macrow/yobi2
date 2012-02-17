class Slide < ActiveRecord::Base
  mount_uploader :image, SlideImageUploader
  validates_presence_of :image
  
  default_scope order("created_at DESC")
  
  def display_image
    image.nil? ? "no-pic.gif" : image.url
  end
  
  def thumb_image
    image.nil? ? "no-pic.gif" : image.thumb.url
  end
end
