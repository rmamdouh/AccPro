class HomepageController < ApplicationController
  def home
    @users = User.all
  end
end
