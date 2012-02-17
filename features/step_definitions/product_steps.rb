# encoding: utf-8

Given /^我作为管理员登陆后台$/ do
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

When /^我进入产品目录添加页面$/ do
  visit '/admin/products'
  click_link I18n.t("actions.named.new", :model => I18n.t("activerecord.models.category"))
end

When /^我填写目录名称为"([^"]*)"$/ do |name|
  fill_in "category[name]", :with => name
end

When /^我点击创建目录$/ do
  click_button I18n.t("helpers.submit.create", :model => I18n.t("activerecord.models.category"))
end

Then /^我应当看到创建目录成功的消息$/ do
  page.should have_content(I18n.t("flash.actions.create.notice", :resource_name => I18n.t("activerecord.models.category")))
end

Given /^有一个名为"([^"]*)"的产品目录$/ do |name|
  Category.create!(:name => name).should_not be_nil
end

When /^我进入"([^"]*)"产品目录编辑页面$/ do |name|
  visit '/admin/categories'
  click_link I18n.t("actions.simple.edit")
end

When /^我点击更新目录$/ do
  click_button I18n.t("helpers.submit.update", :model => I18n.t("activerecord.models.category"))
end

Then /^我应当看到更新目录成功的消息$/ do
  page.should have_content(I18n.t("flash.actions.update.notice", :resource_name => I18n.t("activerecord.models.category")))
end

When /^我对"([^"]*)"产品目录进行删除$/ do |category|
  visit '/admin/categories'
  click_link I18n.t("actions.simple.delete")
end

Then /^我应当看到删除目录成功的消息$/ do
  page.should have_content(I18n.t("flash.actions.destroy.notice", :resource_name => I18n.t("activerecord.models.category")))
end

When /^我进入产品添加页面$/ do
  visit '/admin/products'
  click_link I18n.t("actions.named.new", :model => I18n.t("activerecord.models.product"))
end

When /^我填写产品名称为"([^"]*)"，产品编号为"([^"]*)"，友比价格为"([^"]*)"，零售价格为"([^"]*)"，产品介绍为"([^"]*)"$/ do |name, sn, price_yobi, price_retail, description|
  fill_in "product[name]", :with => name
  fill_in "product[sn]", :with => sn
  fill_in "product[price_yobi]", :with => price_yobi
  fill_in "product[price_retail]", :with => price_retail
  fill_in "product[description]", :with => description
end

When /^我选择目录为"([^"]*)"$/ do |category|
  select category, :from => 'product[category_id]'
end

When /^我点击创建产品$/ do
  click_button I18n.t("helpers.submit.create", :model => I18n.t("activerecord.models.product"))
end

Then /^我应当看到创建产品成功的消息$/ do
  page.should have_content(I18n.t("flash.actions.create.notice", :resource_name => I18n.t("activerecord.models.product")))
end