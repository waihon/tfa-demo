class TfaRecoveriesController < ApplicationController
  before_action :find_user

  def new
  end

  def create
    if @user.authenticate_recovery(params[:recovery_code])
      user_authenticated(@user)
    else
      flash.now[:alert] = "Invalid recovery code!"
      render :new
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
