Given /^I am not logged in$/ do
  visit "/users/sign_out"
end

Given /^I am on the home page$/ do
  visit "/"
end

Given /^I go to the sign up page$/ do
  visit '/users/sign_up'
end

Given /^I fill in the following:$/ do |table|
  table.rows_hash.each do |key, value|
    fill_in(I18n.t("activerecord.attributes.user.#{key.downcase.split(" ").join("_")}"), :with => value)
  end
end

Given /^I press sign up button$/ do
  click_button I18n.t("user.sign_up")
end

Then /^I should see sign up successful message$/ do
  page.should have_content(I18n.t("devise.registrations.signed_up"))
end

Then /^I should see invalid email message$/ do
  page.should have_content(I18n.t("devise.failure.invalid_email"))
end

Then /^I should see password confirmation error message$/ do
  page.should have_content(I18n.t("errors.messages.confirmation"))
end

Given /^no user exists with an email of "([^"]*)"$/ do |email|
  User.where(:email => email).first.should be_nil
end

When /^I go to the sign in page$/ do
  visit '/users/sign_in'
end

When /^I sign in with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  fill_in(I18n.t("activerecord.attributes.user.email"), :with => email)
  fill_in(I18n.t("activerecord.attributes.user.password"), :with => password)
  click_button I18n.t("user.sign_in")
end

Then /^I should see invalid email or password message$/ do
  page.should have_content(I18n.t("devise.failure.invalid"))
end

Then /^I go to the account page$/ do
  visit '/users/account'
end

Then /^I should be signed out$/ do
  visit '/users/account'
  page.should have_content(I18n.t("user.sign_in"))
end


Given /^I am a user named "([^"]*)" with an email "([^"]*)" and password "([^"]*)"$/ do |name, email, password|
  User.create!(:name => name, :email => email, :password => password).should_not be_nil
end

Then /^I should see signed in successful message$/ do
  page.should have_content(I18n.t("devise.sessions.signed_in"))
end

Then /^I should be signed in$/ do
  page.should have_content(I18n.t("devise.sessions.signed_in"))
end

When /^I return next time$/ do
  visit '/'
end

Then /^I should be already signed in$/ do
  visit '/users/account'
  page.should have_content(I18n.t("user.sign_out"))
end

Then /^I sign out$/ do
  visit '/users/sign_out'
end

Then /^I should see signed out message$/ do
  page.should have_content(I18n.t("devise.sessions.signed_out"))
end

When /^I follow edit account link$/ do
  click_link I18n.t("user.edit_password")
end

When /^I fill in name with baz$/ do
  fill_in I18n.t("activerecord.attributes.user.name"), :with => "baz"
end

When /^I fill in current password with please$/ do
  fill_in I18n.t("activerecord.attributes.user.current_password"), :with => "please"
end

When /^I press update button$/ do
  click_button I18n.t("helpers.submit.update").gsub(/%{model}/, I18n.t("activerecord.models.user"))
end

When /^I should see registrations information updated message$/ do
  page.should have_content(I18n.t("devise.registrations.updated"))
end

Then /^I should see user named baz$/ do
  visit '/users/account'
  page.should have_content("baz")
end