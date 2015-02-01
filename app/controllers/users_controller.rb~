class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params['id'])
    @posts = @user.posts.order("created_at DESC")
  end

  def following
    @following = []
    @relations = Relationship.where(:follower_id => params['id'])
    @relations.each do |relation|
      @following << User.find(relation.followed_id)
    end
  end

  def followers
    @follower = []
    @relations = Relationship.where(:followed_id => params['id'])
    @relations.each do |relation|
      @follower << User.find(relation.follower_id)
    end
  end

  def destroy
    @user = User.find(params['id'])
    @posts = @user.posts
  end

end
