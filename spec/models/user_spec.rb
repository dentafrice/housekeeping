require 'spec_helper'
require 'cancan/matchers'

describe User do
  describe "abilities" do
    subject { ability }
    let(:ability) { Ability.new(user) }

    context "when user is an admin" do
      let(:user) { FactoryGirl.create(:admin_user) }

      it "should have an admin role" do
        user.has_role?(:admin).should be_true
      end

      it "should be able to manage other admins" do
        should be_able_to(:manage, FactoryGirl.create(:admin_user))
      end

      it "should not be able to manage super admins" do
        should_not be_able_to(:manage, FactoryGirl.create(:super_admin_user))
      end
    end

    context "when user is a super admin" do
      let(:user) { FactoryGirl.create(:super_admin_user) }

      it "should have a super admin role" do
        user.has_role?(:super_admin).should be_true
      end

      it "should be able to manage other admins" do
        should be_able_to(:manage, FactoryGirl.create(:admin_user))
      end

      it "should be able to manage other super admins" do
        should be_able_to(:manage, FactoryGirl.create(:super_admin_user))
      end
    end

    context "when user is a staff member" do
      let(:user) { FactoryGirl.create(:staff_user) }

      it "should be able to manage themselves" do
        should be_able_to(:manage, user)
      end

      it "should not be able to manage another staff user" do
        should_not be_able_to(:manage, FactoryGirl.create(:staff_user))
      end

      it "should not be able to manage an admin" do
        should_not be_able_to(:manage, FactoryGirl.create(:admin_user))
      end
    end
  end

  describe "roles" do
    subject { user }

    context "when a user has no roles" do
      let(:user) { FactoryGirl.build(:no_role_user) }

      it "should not be valid" do
        user.roles.should have(0).items
      end

      it "should add the staff role when saving" do
        user.save
        user.roles.should have(1).items
        user.has_role?(:staff).should be_true
      end
    end

    context "when a user has a role" do
      let(:user) { FactoryGirl.create(:staff_user) }

      it "should only have one role" do
        user.roles.count.should == 1
      end

      describe "and is banned" do
        before do
          user.add_role :banned
        end

        it "should have the banned role" do
          user.has_role?(:banned).should be_true
        end

        it "should only have one role" do
          user.roles.count.should == 1
        end
      end

      describe "and is promoted to staff" do
        before do
          user.add_role :staff
        end

        it "should not be banned" do
          user.has_role?(:banned).should be_false
        end

        it "should have one role" do
          user.roles.count.should == 1
        end

        it "should have the staff role" do
          user.has_role?(:staff).should be_true
        end
      end
    end
  end
end