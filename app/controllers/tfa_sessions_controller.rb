class TfaSessionsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    if @user.authenticate_otp(params[:authentication_code])
      user_authenticated(@user)
    else
      flash.now[:alert] = "Invalid authentication code!"
      render :new
    end
  end
end
