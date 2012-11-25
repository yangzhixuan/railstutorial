class UsersController < ApplicationController
  def new
    @title = "Sign up"
    @user = User.new
  end

  def show
    @user = User.find params[:id]
    @title = @user.name
  end

  def index
    @allUsers = User.all
    @title = "All users"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to YangZX's Homepage"
      redirect_to @user
    else
      @title = "Invalid information"
      render 'new'
    end
  end
end
