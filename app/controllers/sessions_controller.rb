class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.where(email: params[:user][:email]).first
    if user.present? && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      flash[:notice] = 'Logged in Successfully'
      redirect_to root_path
    else
      flash[:alert]  = 'Something went wrong: login'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice]    = "Logged out"
    redirect_to root_path
  end
end
