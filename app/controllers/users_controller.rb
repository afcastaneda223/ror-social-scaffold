class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent

    @pendings = User.pending_friendships(current_user)

    @status = nil 
    if current_user == @user
      @status = "none"
    elsif Friendship.where(user_id: params[:id], friend_id: current_user.id, status: false)
      @status = "accept"
    elsif Friendship.where(user_id:current_user.id, friend_id:params[:id], status: false)
      @status = "pending"

    elsif Friendship.where(user_id: params[:id], friend_id: current_user.id, status: true)
      @status = "unfriend"
    elsif Friendship.where(user_id:current_user.id, friend_id:params[:id], status: true)
      @status = "unfriend"

    else
      @status = "invite"
    end
  end

  




end
