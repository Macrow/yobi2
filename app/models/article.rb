class Article < ActiveRecord::Base  
  validates_presence_of :title
  validates_uniqueness_of :url
  
  default_scope order("id DESC")
  
  has_many :images, :class_name => "ArticleImage", :dependent => :destroy
  has_one :major_image, :class_name => "ArticleImage", :conditions => ["is_major = ?", true]
  
  before_save :verify_safe
  before_validation :generate_url
  
  acts_as_taggable
  
  def display_image
    major_image.nil? ? "no-banner-pic-article.jpg" : major_image.image.url
  end
  
  def thumb_image
    major_image.nil? ? "no-pic.gif" : major_image.image.thumb.url
  end
  
  def tags_text=(text)
    self.tag_list = text.split(" ")
  end
  
  def tags_text
    self.tag_list.join(" ")
  end

  private  
  def verify_safe
    unless self.content.html_safe?
      self.content.gsub!(/<script.*?>.*?<\/script>/i, "")
    end
  end
  
  def generate_url
    if self.url.blank?
      self.url = self.title.to_url.to(Yobi::URL_COUNT)
    else
      self.url = self.url.to_url.to(Yobi::URL_COUNT)
    end
  end
end
