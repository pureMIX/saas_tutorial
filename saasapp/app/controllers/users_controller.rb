class UsersController < ApplicationController
  before_action :authenticate_user!
  # Get to /users
  def index
    # Get all users
    @users = User.includes(:profile)
  end
  
  # GET to /users/:id
  def show
    @user = User.find(params[:id])
  end
  
end