FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :admin_user, :class => User do |user|
    sequence(:username) { |n| "admin_user_#{n}" }
    password "testing"
    email

    after(:create) { |instance| instance.add_role :admin }
  end

  factory :super_admin_user, :class => User do
    sequence(:username) { |n| "super_admin_user_#{n}" }
    password "testing"
    email

    after(:create) { |instance| instance.add_role :super_admin }
  end

  factory :staff_user, :class => User do
    sequence(:username) { |n| "staff_user_#{n}" }
    password "testing"
    email

    after(:create) { |instance| instance.add_role :staff }
  end

  factory :banned_user, :class => User do
    sequence(:username) { |n| "banned_user_#{n}" }
    password "testing"
    email

    after(:create) { |instance| instance.add_role :banned }
  end

  factory :no_role_user, :class => User do
    sequence(:username) { |n| "no_role_user_#{n}" }
    password "testing"
    email
  end
end