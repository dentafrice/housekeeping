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

  def authorize(user = nil)
    authorize! :manage, user unless user.nil?
  end
end