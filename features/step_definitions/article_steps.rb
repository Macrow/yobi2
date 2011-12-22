# encoding: utf-8

Given /^我已经以管理员身份登陆管理后台$/ do
  email = "admin@yeah.net"
  password = "password"
  admin = User.create!({:name => "admin", :email => email, :password => password, :is_admin => true}, :as => :admin)
  admin.should_not be_nil
  admin.is_admin.should be_true
  visit '/users/account'
  fill_in(I18n.t("activerecord.attributes.user.login"), :with => email)
  fill_in(I18n.t("activerecord.attributes.user.password"), :with => password)
  click_button I18n.t("user.sign_in")
  page.should have_content(I18n.t("devise.sessions.signed_in"))
  visit '/admin'
end

When /^发表一篇题目为"([^"]*)",内容为"([^"]*)"的文章$/ do |title, content|
  click_link I18n.t("activerecord.models.article")
  click_link I18n.t("actions.named.new", :model => I18n.t("activerecord.models.article"))
  fill_in I18n.t("activerecord.attributes.article.title"), :with => title
  fill_in I18n.t("activerecord.attributes.article.content"), :with => content
  click_button I18n.t("helpers.submit.create", :model => I18n.t("activerecord.models.article"))
end

When /^发表一篇题目为"([^"]*)",内容为"([^"]*)"的文章，地址为"([^"]*)"$/ do |title, content, url|
  click_link I18n.t("activerecord.models.article")
  click_link I18n.t("actions.named.new", :model => I18n.t("activerecord.models.article"))
  fill_in I18n.t("activerecord.attributes.article.title"), :with => title
  fill_in I18n.t("activerecord.attributes.article.url"), :with => url
  fill_in I18n.t("activerecord.attributes.article.content"), :with => content
  click_button I18n.t("helpers.submit.create", :model => I18n.t("activerecord.models.article"))
end

Then /^我应当看到发表成功的消息$/ do
  page.should have_content(I18n.t("flash.actions.create.notice", :resource_name => I18n.t("activerecord.models.article")))
end

Then /^我在前台打开地址为"([^"]*)"的文章，会看到"([^"]*)"的题目，会看到"([^"]*)"的内容$/ do |url, title, content|
  url = Article.string_to_url(url)
  visit "/articles/#{url}"
  page.should have_content(title)
  page.should have_content(content)
end

When /^我对这篇文章进行编辑，将题目修改为"([^"]*)"，内容修改为"([^"]*)"$/ do |title, content|
  click_link I18n.t("activerecord.models.article")
  find('#article_list').click_link(I18n.t("actions.simple.edit"))
  fill_in I18n.t("activerecord.attributes.article.title"), :with => title
  fill_in I18n.t("activerecord.attributes.article.content"), :with => content
  click_button I18n.t("helpers.submit.update", :model => I18n.t("activerecord.models.article"))
end

When /^我对这篇文章进行编辑，将题目修改为"([^"]*)"，内容修改为"([^"]*)"，地址修改为"([^"]*)"$/ do |title, content, url|
  click_link I18n.t("activerecord.models.article")
  find('#article_list').click_link(I18n.t("actions.simple.edit"))
  fill_in I18n.t("activerecord.attributes.article.title"), :with => title
  fill_in I18n.t("activerecord.attributes.article.url"), :with => url
  fill_in I18n.t("activerecord.attributes.article.content"), :with => content
  click_button I18n.t("helpers.submit.update", :model => I18n.t("activerecord.models.article"))
end

Then /^我应当看到修改成功的消息$/ do
  page.should have_content(I18n.t("flash.actions.update.notice", :resource_name => I18n.t("activerecord.models.article")))
end

When /^我对这篇文章进行删除$/ do
  click_link I18n.t("activerecord.models.article")
  find('#article_list').click_link(I18n.t("actions.simple.delete"))
end

Then /^我应当看到删除成功的消息$/ do
  page.should have_content(I18n.t("flash.actions.destroy.notice", :resource_name => I18n.t("activerecord.models.article")))
end

Then /^我在前台打开地址为"([^"]*)"的文章，会看到不存在的404页面$/ do |url|
  url = Article.string_to_url(url)
  Article.find_by_url(url).should be_nil
end