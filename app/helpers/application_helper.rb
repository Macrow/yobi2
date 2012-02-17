module ApplicationHelper
  def conditional_html( lang = "en", &block )
    haml_concat Haml::Util::html_safe <<-"HTML".gsub( /^\s+/, '' )
      <!--[if lt IE 7 ]>              <html lang="#{lang}" class="no-js ie6 oldie"> <![endif]-->
      <!--[if IE 7 ]>                 <html lang="#{lang}" class="no-js ie7 oldie"> <![endif]-->
      <!--[if IE 8 ]>                 <html lang="#{lang}" class="no-js ie8 oldie"> <![endif]-->
      <!--[if IE 9 ]>                 <html lang="#{lang}" class="no-js ie9"> <![endif]-->
      <!--[if (gte IE 9)|!(IE)]><!--> <html lang="#{lang}" class="no-js"> <!--<![endif]-->      
    HTML
    haml_concat capture( &block ) << Haml::Util::html_safe( "\n</html>" ) if block_given?
  end
  
  def display_banner_image
    image = @banner_image.nil? ? "no-pic-banner.jpg" : @banner_image
    image_tag(image, :size => "936x240")
  end
  
  def show_price(price)
    number_to_currency(price, :unit => I18n.t("number.currency.format.unit"))
  end
  
  def show_breadcrumbs
    return nil if controller_name == "home" && action_name == "index"
    return nil if controller_name == "redirect"
    output = content_tag(:li, link_to(t("yobi.site_name"), root_path, :rel => "nofollow"))
    if controller_name =~ /^categories|products/i && action_name == "show"
      unless @category.nil?
        @category.ancestors.all.each do |c|
          output << content_tag(:li, link_to(c.name, category_url_path(c.url)))
        end
        output << content_tag(:li, link_to(@category.name, category_url_path(@category.url)))
      end
    end
    if controller_name == "products" && action_name == "show"
      output << content_tag(:li, link_to(@product.name, product_url_path(@product.url)))
    end
    if controller_name == "articles" && action_name == "show"
      output << content_tag(:li, link_to(@article.title, article_url_path(@article.url)))
    end
    if controller_name =~ /passwords|registrations|sessions|users/i
      output << content_tag(:li, t("yobi.user_center"))
    end
    if controller_name == "home"
      if action_name == "search"
        output << content_tag(:li, "#{t("actions.simple.search")}: \"#{params[:search][:name_contains]}\"")
      elsif action_name == "tags"
        output << content_tag(:li, "#{t('yobi.tag')}: #{params[:tag]}")
      elsif action_name == "sitemap"
        output << content_tag(:li, link_to(t("yobi.sitemap"), sitemap_path))
      end
    end
    content_tag(:ul, content_tag(:div, output.html_safe), :class => "breadcrumbs")
  end
  
  def show_footer_categories(categories)
    categories.to_a.collect do |c|
      content_tag(:div, :class => "products") do
        concat content_tag(:h6, link_to(c[0].name, category_url_path(c[0].url)))
        content_tag(:ul, c[1].to_a.collect { |cc| concat content_tag(:li, link_to(cc[0].name, category_url_path(cc[0].url))) }, :class => "disc") if c[1].length > 0
      end
    end.join.html_safe
  end
end
