class Admin::UsersController < Admin::AdminController
  before_filter :authorize
  load_and_authorize_resource

  def index
    @users = current_user.manageable_users
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    render :text => "Hey!"
  end

  def edit
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    @user.update_attributes(params[:user])

    if @user.save
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def authorize(user = nil)
    authorize! :manage, user unless user.nil?
  end
end