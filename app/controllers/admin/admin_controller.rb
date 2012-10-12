class Admin::AdminController < ApplicationController
  before_filter :authorize_admin

  rescue_from CanCan::AccessDenied do
    not_authorized
  end

  protected
  def authorize_admin
    unless current_user.is_admin?
      not_authorized
    end
  end
end