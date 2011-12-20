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
  
  def slider_image_tag(image, option = {})
    image_tag("slider-images/#{image}", option).html_safe
  end
end
