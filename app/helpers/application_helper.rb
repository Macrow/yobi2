#encoding: utf-8
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
  
  def title(page_title, show_title = true)
    content_for(:title) { page_title.to_s }
    @show_title = show_title
  end
  
  def title_with_sitename(page_title, show_title = true)
    content_for(:title) { "#{page_title.to_s} - 友比财务商城" }
    @show_title = show_title
  end
  
  def title_with_page_and_sitename(name, page)
    if page
      title_with_sitename "第#{params[:page]}页 #{name}"
    else
      title_with_sitename name    
    end
  end

  def show_title?
    @show_title
  end
  
  def default_title
    "友比财务商城"
  end
  
  def meta_content(keywords, description)
    keywords = "财务软件,财务配套,装订机,凭证,账册" if keywords.blank?
    description = "友比财务商城-国内专业财务配套用品网上商城，为您提供：财务软件、财务表单（会计套打账册、业务表单）、装订系列（装订机、胶装机）、打印软件(套打软件、万能票据)等，满足财务电算化日常办公所需，实现企业规范、专业的信息化管理。" if description.blank?
    content_for :meta do
      concat "<meta name='Keywords', content='#{keywords}' />\n".html_safe
      concat "<meta name='Description', content='#{description}' />".html_safe
    end
  end
  
  def default_meta_content
    %Q{
      <meta name='Keywords', content='财务软件,财务配套,装订机,凭证,账册'>
      <meta name='Description', content='友比财务商城-国内专业财务配套用品网上商城，为您提供：财务软件、财务表单（会计套打账册、业务表单）、装订系列（装订机、胶装机）、打印软件(套打软件、万能票据)等，满足财务电算化日常办公所需，实现企业规范、专业的信息化管理。'>
    }.html_safe
  end
  
  def meta_nofollow
    content_for :meta do
      "<meta name='robots' content='noindex, nofollow' />\n".html_safe
    end
  end
  
  def canonical_link(url)
    content_for :meta do
      "<link rel='canonical' href='#{url}'/>\n".html_safe
    end
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
      output << content_tag(:li, link_to(@product.title, product_url_path(@product.url)))
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
