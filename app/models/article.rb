class Article < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  
  validates_presence_of :title
  validates_uniqueness_of :url
  
  default_scope order("created_at DESC")
  
  before_save :verify_safe, :generate_url
  
  def self.string_to_url(str)
    str.to_url
  end

  private
  
  def verify_safe
    unless self.content.html_safe?
      self.content.gsub!(/<script.*?>.*?<\/script>/i, "")
    end
  end
  
  def generate_url
    if self.url.blank?
      self.url = self.title.to_url
    else
      self.url = self.url.to_url
    end
  end
end
