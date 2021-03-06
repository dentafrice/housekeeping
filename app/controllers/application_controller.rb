class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource
  before_filter :banned?

  def not_authorized
    flash[:alert] = "Sorry, you do not have access to this resource."
    redirect_to dashboard_index_path
  end

  protected
  def layout_by_resource
    if devise_controller?
      "logged_out"
    else
      "application"
    end
  end

  def banned?
    if current_user.present? && current_user.has_role?(:banned)
      sign_out current_user
      flash[:alert] = "This account has been suspended."
      redirect_to new_user_session_path
    end
  end
end