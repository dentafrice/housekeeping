class Profile < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :skype
  belongs_to :user
end