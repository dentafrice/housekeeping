class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :super_admin
      can :manage, :all
    elsif user.has_role? :admin
      can :manage, User do |user|
        !user.has_role?(:super_admin)
      end
    elsif user.has_role? :staff
      can :manage, User, :id => user.id
    else
      # Basic User with no access.
    end
  end
end
