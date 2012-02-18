#encoding: utf-8
class Product < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :name, :category
  validates_uniqueness_of :url
  validates_numericality_of :price_yobi, :price_retail, :greater_than_or_equal_to => 0
  
  belongs_to :category
  has_many :images, :class_name => "ProductImage", :dependent => :destroy
  has_one :major_image, :class_name => "ProductImage", :conditions => ["is_major = ?", true]
  has_many :properties, :dependent => :destroy
  accepts_nested_attributes_for :properties, :reject_if => :all_blank, :allow_destroy => true
  
  before_validation :update_properties_name_from_entered, :generate_url
  before_save :verify_safe, :update_plists
  
  acts_as_taggable
  
  default_scope order("created_at DESC")
  
  def tags_text=(text)
    self.tag_list = text.split(" ")
  end
  
  def tags_text
    self.tag_list.join(" ")
  end
  
  def title
    name + " - " + sn
  end
  
  def discount
    begin
      discount = ((price_yobi.to_f/price_retail.to_f)*100).to_i.to_s + "%"
    rescue
      discount = "N/A"
    end
    discount
  end
  
  def display_image
    major_image.nil? ? "no-pic-product.jpg" : major_image.image.url
  end
  
  def thumb_image
    major_image.nil? ? "no-pic-product-thumb.jpg" : major_image.image.thumb.url
  end
  
  def meta_keywords
    "#{self.title},财务配套用品,装订机,财务软件"
  end
  
  def meta_description
    "#{self.title},专业财务系列产品,友比最新价格为#{price_yobi}元,为您节省开支!"
  end
  
  private
 
  def verify_safe
    unless self.description.html_safe?
      self.description.gsub!(/<script.*?>.*?<\/script>/i, "")
    end
  end
  
  def generate_url
    if self.url.blank?
      self.url = (self.title).to_url.to(Yobi::URL_COUNT)
    else
      self.url = self.url.to_url.to(Yobi::URL_COUNT)
    end
  end
  
  def update_properties_name_from_entered
    self.properties.each { |property| property.name = property.name_entered unless property.name_entered.blank? }
  end
  
  def update_plists
    plists = Plist.all.collect(&:name)
    properties.each { |property| Plist.create(:name => property.name) unless plists.include?(property.name) }
  end
end
