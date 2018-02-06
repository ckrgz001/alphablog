class SessionsController < ApplicationController

  def new
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash.now[:success] = "You have successfully logged in."
      redirect_to user_path(user)
    else
      flash.now[:danger] = "An error has occured during login. Please check your info."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash.now[:success] = "You have logged out."
    redirect_to root_path
    
  end

end

