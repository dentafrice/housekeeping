class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  after_create :create_profile

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :role

  validates_uniqueness_of :username
  before_save :ensure_roles

  has_one :profile, :dependent => :delete

  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  def display_name
    self.username.titleize
  end

  def add_role(role, resource = nil)
    super(role, resource)

    self.process_roles(role)
  end

  # If a user is getting banned, we need to remove all other roles.
  # If a user was banned and is getting another role, we should remove the banned role.
  def process_roles(to_role)
    if self.has_role?(:banned) && to_role == :banned
      self.roles.where('name != ?', 'banned').each{ |role| role.delete }
    elsif self.has_role?(:banned)
      self.remove_role :banned
    end
  end

  private
  def create_profile
    self.build_profile.save
  end

  def ensure_roles
    if self.roles.count == 0
      self.add_role :staff
    end
  end
end