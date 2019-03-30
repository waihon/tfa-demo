class TfasController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @user.prepare_tfa
  end

  def create
    @user = User.find(params[:user_id])
    if @user.authenticate_otp(params[:verification_code])
      @user.enable_tfa
      flash[:notice] = "Two Factor Authentication has been successfully enabled!"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "Invalid verification code!"
      render :new
    end
  end
end
