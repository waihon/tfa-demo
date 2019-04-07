class TfasController < ApplicationController
  before_action :find_user_id
  before_action :require_signin
  before_action :require_correct_user, only: [:show]

  def new
    @user.prepare_tfa
  end

  def create
    if @user.authenticate_otp(params[:authentication_code])
      @user.enable_tfa
      flash[:notice] = "Two-Factor Authentication has been successfully enabled!"
      redirect_to user_tfa_path(@user)
    else
      flash.now[:alert] = "Invalid authentication code!"
      render :new
    end
  end

  def show
  end

  private

  def find_user_id
    @user = User.find(params[:user_id])
  end

  def require_correct_user
    redirect_to root_url unless current_user?(@user)
  end
end
