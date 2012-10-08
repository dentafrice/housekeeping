class Role < ActiveRecord::Base
  attr_accessible :name
  has_many :users, :through => :user_roles
  has_many :user_roles

  def display_name
    self.name.titleize
  end
end