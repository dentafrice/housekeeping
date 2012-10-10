class Admin::AdminController < ApplicationController
  before_filter :authorize

  def authorize
    #unless current_user.role? :admin
    #  flash[:alert] = "You do not have access to this page."
    #  redirect_to dashboard_index_path
    #end
  end
end