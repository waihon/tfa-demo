class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate(params[:email_or_username], params[:password])
      if validate_recaptcha
        session[:user_id] = user.id
        flash[:notice] = "Welcome back, #{user.name}!"
        redirect_to(session[:intended_url] || user)
        session[:intended_url] = nil
      else
        flash.now[:alert] = "Please complete the reCAPTCHA verification."
        render :new
      end
    else
      flash.now[:alert] = "Invalid email/username/password combination!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You're now signed out!"
  end
end
