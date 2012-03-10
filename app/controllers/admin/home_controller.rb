module Admin
  class HomeController < BaseController
    def index
      @names = %W{Slide Article ArticleImage Product ProductImage Category CategoryImage User}
      @counts = []
      begin
        @names.each do |name|
          @counts << name.constantize.count
        end
      rescue
      end
    end
    
    def generate_sitemap
      map = XmlSitemap::Map.new('www.51yobi.com') do |m|
        Product.all.each { |p| m.add "products/#{p.url}", :updated => Date.today, :period => :monthly, :priority => 1.0 }
        Article.all.each { |a| m.add "articles/#{a.url}", :updated => Date.today, :period => :monthly, :priority => 0.5 }
      end
      map.render
      map.render_to("#{Rails.public_path}/sitemap.xml")

      redirect_to admin_root_path, :notice => "xml sitemap files generated!"
    end
  end
end

