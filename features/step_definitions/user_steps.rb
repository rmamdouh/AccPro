# Add a declarative step here for populating the DB with users.

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(user)
  end
end

Given /^a valid admin$/ do
  @user = User.create!({
             :email => "admin@admin.com",
             :password => "12345678",
             :password_confirmation => "12345678",
             :admin => true
           })
end

Given /^a valid user$/ do
  @user = User.create!({
             :email => "user@user.com",
             :password => "12345678",
             :password_confirmation => "12345678",
             :admin => false
           })
end

Given /^a logged in admin$/ do
  Given "a valid admin"
  visit signin_url
  fill_in "Email", :with => "admin@admin.com"
  fill_in "Password", :with => "12345678"
  click_button "Sign in"
end

Given /^a logged in user$/ do
  Given "a valid user"
  visit signin_url
  fill_in "Email", :with => "user@user.com"
  fill_in "Password", :with => "12345678"
  click_button "Sign in"
end

