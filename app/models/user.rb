class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  after_create :create_profile

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :role

  has_and_belongs_to_many :roles, :join_table => 'user_roles'
  has_one :profile, :dependent => :delete

  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  def display_name
    self.username.titleize
  end

  private
  def create_profile
    self.build_profile.save
  end
end