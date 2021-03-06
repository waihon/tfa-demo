class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      if validate_recaptcha
        if @user.save
          session[:user_id] = @user.id
          redirect_to @user, notice: 'Thanks for signing up!'
        else
          render :new
        end
      else
        flash.now[:alert] = "Please complete the reCAPTCHA verification."
        render :new
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Account successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil # auto sign out the user after deleting it
    redirect_to root_path, alert: "Account successfully deleted!"
  end

  private

  def user_params
    params.require(:user).
      permit(:name, :username, :email, :password, :password_confirmation)
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end
end
