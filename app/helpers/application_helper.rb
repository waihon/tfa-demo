module ApplicationHelper
  # https://gist.github.com/roberto/3344628
  def bootstrap_class_for(flash_type)
    case flash_type.to_s
    when "success"
      "alert-success" # Green
    when "error"
      "alert-danger" # Red
    when "alert"
      "alert-warning" # Yellow
    when "notice"
      "alert-info" # Blue
    else
      flash_type.to_s
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
