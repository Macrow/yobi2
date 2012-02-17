module Admin
  module ApplicationHelper
    def topbar
      content_tag(:ul, :class => "nav") do
        concat content_tag(:li, link_to(t("yobi.home"), admin_root_path), :class => ("active" if controller_name =~ /^home/i))
        concat content_tag(:li, link_to(t("activerecord.models.slide"), admin_slides_path), :class => ("active" if controller_name =~ /^slides/i))
        concat content_tag(:li, link_to(t("activerecord.models.article"), admin_articles_path), :class => ("active" if controller_name =~ /^articles/i))
        concat content_tag(:li, link_to(t("activerecord.models.product"), admin_products_path), :class => ("active" if controller_name =~ /^products|plists|product_images/i))
        concat content_tag(:li, link_to(t("activerecord.models.category"), admin_categories_path), :class => ("active" if controller_name =~ /^categories|category_images/i))
        concat content_tag(:li, link_to(t("activerecord.models.user"), admin_users_path), :class => ("active" if controller_name =~ /^users/i))
        concat content_tag(:li, link_to(t("yobi.website"), root_path, :target => "_blank"))
      end.html_safe
    end
    
    def display_bar(max, count)
      width = 500
      content_tag(:div, "", :class => "count", :style => "width:#{width * count.to_i / max.to_i}px").html_safe
    end
    
    def suckerfish(categories)
  	  categories.map do |category, sub_category|
  	  	  content_tag :li, :id => dom_id(category), :class => cycle('alert-message success', 'alert-message info') do
  	  	  	render(category) + (content_tag(:ul, suckerfish(sub_category)) if sub_category.present?)
  	  	  end
  	  end.join.html_safe
  	end
  	
  	def toggle_image_major(item, image)
  	  if item.is_a?(Product)
        %Q{
        $.ajax({
              url: '#{admin_product_image_path(item, image)}',
              type: 'PUT',
              data: this.name + '=' + this.checked,
              dataType: 'script'
            });
        }.gsub(/[\n ]+/, ' ').strip.html_safe
      elsif item.is_a?(Category)
        %Q{
        $.ajax({
              url: '#{admin_category_image_path(item, image)}',
              type: 'PUT',
              data: this.name + '=' + this.checked,
              dataType: 'script'
            });
        }.gsub(/[\n ]+/, ' ').strip.html_safe
      elsif item.is_a?(Article)
        %Q{
        $.ajax({
              url: '#{admin_article_image_path(item, image)}',
              type: 'PUT',
              data: this.name + '=' + this.checked,
              dataType: 'script'
            });
        }.gsub(/[\n ]+/, ' ').strip.html_safe  
      end
    end
  	
  	def image_uploadify(container, path, model_name, btn_label)
      session_key_name = Rails.application.config.session_options[:key]
      %Q{
      <script type='text/javascript'>
        $(document).ready(function() {
          $('#{container}').uploadify({
            script          : '#{path}',
            fileDataName    : '#{model_name}[#{model_name}]',
            uploader        : '#{asset_path("admin/uploadify/uploadify.swf")}',
            cancelImg       : '#{asset_path("admin/uploadify/cancel.png")}',
            fileDesc        : 'Images',
            fileExt         : '*.png;*.jpg;*.gif',
            sizeLimit       : #{10.megabytes},
            queueSizeLimit  : 24,
            multi           : true,
            auto            : true,
            buttonText      : '#{btn_label}',
            scriptData      : {
              '_http_accept': 'application/javascript',
              '#{session_key_name}' : encodeURIComponent('#{u(cookies[session_key_name])}'),
              'authenticity_token'  : encodeURIComponent('#{u(form_authenticity_token)}')
            },
            onComplete      : function(a, b, c, response){ eval(response) }
          });
        });
      </script>
      }.gsub(/[\n ]+/, ' ').strip.html_safe
    end
  end
end