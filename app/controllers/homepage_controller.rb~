class HomepageController < ApplicationController
  def home
    @posts = []
    @users = User.all
    @users.each do |user|
      @posts << user.posts.order("created_at DESC")
    end
  end
end
