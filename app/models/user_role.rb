class UserRole < ActiveRecord::Base
  attr_accessible :role_id, :user_id, :role, :user
  has_one :user
  has_one :role
end
