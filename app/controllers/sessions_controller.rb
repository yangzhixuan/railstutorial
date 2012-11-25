class SessionsController < ApplicationController
  def new
    @title = "Sign in" 
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      @title = "Invaid information "
      flash[:error] = "Invalid email or password, contact with the administrator if you forget your password"
      render 'new' 
    else
      sign_in user, params[:session][:remember_me]
      flash[:success] = "Log in successfully"
      redirect_to user 
    end
  end

  def destroy
    sign_out
    flash[:success] = "Log out successfully"
    redirect_to root_path
  end

end
