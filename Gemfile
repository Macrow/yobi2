require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem 'mysql2'

group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
	gem 'compass', '~> 0.12.alpha'
end

gem 'twitter-bootstrap-rails', "1.4.1"
gem 'jquery-rails'

if HOST_OS =~ /linux/i
  gem 'therubyracer', '>= 0.9.8'
end

gem "haml", ">= 3.1.2"
gem "haml-rails", ">= 0.3.4"
gem "devise", ">= 1.5.0"
gem "inherited_resources"
gem 'simple_form', ">= 2.0.0.rc"
gem "stringex"
gem "carrierwave"
gem "rails_kindeditor"
gem "ancestry"
gem "cocoon"
gem "mini_magick"
gem "flash_cookie_session"
gem "meta_search"
gem 'will_paginate', '~> 3.0'
gem 'acts-as-taggable-on', '~>2.2.0'
gem 'truncate_html'
gem 'cacheable_flash'
gem 'xml-sitemap'

gem "rspec-rails", ">= 2.8.0.rc1", :group => [:development, :test]

group :test do
	gem "factory_girl_rails", ">= 1.4.0"
	gem "cucumber-rails", ">= 1.2.0"
	gem "capybara", ">= 1.1.2"
	gem "database_cleaner", ">= 0.7.0"
	gem "launchy", ">= 2.0.5"
end

group :development do
	gem "guard", ">= 0.6.2"
	case HOST_OS
	  when /darwin/i
	    gem 'rb-fsevent'
	    gem 'growl'
	  when /linux/i
	    gem 'libnotify'
	    gem 'rb-inotify'
	  when /mswin|windows/i
	    gem 'rb-fchange'
	    gem 'win32console'
	    gem 'rb-notifu'
	end
	gem "guard-bundler", ">= 0.1.3"
	gem "guard-rails", ">= 0.0.3"
	gem "guard-livereload", ">= 0.3.0"
	gem "guard-rspec", ">= 0.4.3"
	gem "guard-cucumber", ">= 0.6.1"
	gem "rails-footnotes", ">= 3.7"
	gem "spork"
	gem "guard-spork"
	gem "ruby_gntp"
	gem 'ruby-debug19', :platforms => :mri_19
  gem 'ruby-debug', :platforms => :mri_18
end

