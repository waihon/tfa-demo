class ApplicationController < ActionController::Base

  private

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to signin_url, alert: "Please sign in first!"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user
  helper_method :current_user?

  def validate_recaptcha
    begin
      recaptcha = Recaptcha.new(params[:gtoken] || params[:'g-recaptcha-response'],
                                Rails.application.credentials.recaptcha[:site_key],
                                Rails.application.credentials.recaptcha[:secret_key])
      recaptcha.verify
    rescue => e
      input_errors = [ "Failed recaptcha! timeout-or-duplicate",
                       "Failed recaptcha! missing-input-response",
                       "Failed recaptcha! invalid-input-response"
                       ]
      if input_errors.include?(e.message)
        return false
      else
        raise e.message
      end
    end
  end
end
