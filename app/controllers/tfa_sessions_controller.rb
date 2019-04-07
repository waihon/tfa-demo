class TfaSessionsController < ApplicationController
  before_action :find_user

  def new
  end

  def create
    if @user.authenticate_otp(params[:authentication_code])
      user_authenticated(@user)
    else
      flash.now[:alert] = "Invalid authentication code!"
      render :new
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
