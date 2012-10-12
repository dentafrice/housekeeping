require 'spec_helper'

describe Admin::UsersController do
  render_views

  describe "viewing the index page" do
    context "a staff user" do
      before do
        @user = FactoryGirl.create(:staff_user)
        sign_in @user
      end

      it "should redirect them back to the dashboard" do
        get :index
        response.should redirect_to(dashboard_index_path)
      end
    end

    context "an admin user" do
      before do
        @admin_user = FactoryGirl.create(:admin_user)
        @super_admin_user = FactoryGirl.create(:super_admin_user)
        sign_in @admin_user
      end

      it "should render the page and only display non-super admin users" do
        get :index
        response.body.should =~ /#{@admin_user.username}/
        response.body.should_not =~ /#{@super_admin_user.username}/
      end
    end

    context "a super admin user" do
      before do
        @super_admin_user = FactoryGirl.create(:super_admin_user)
        @normal_user = FactoryGirl.create(:staff_user)
        sign_in @super_admin_user
      end

      it "should render the page and only display non-super admin users" do
        get :index
        response.body.should =~ /#{@super_admin_user.username}/
        response.body.should =~ /#{@normal_user.username}/
      end
    end
  end

  describe "attempting to view an individual user" do
    context "a super admin user" do
      before do
        @user = FactoryGirl.create(:super_admin_user)
        @other_super_admin = FactoryGirl.create(:super_admin_user)
        @admin_user = FactoryGirl.create(:admin_user)

        sign_in @user
      end

      it "should render the show page for a super admin user" do
        get :show, :id => @other_super_admin.id
        response.should render_template('show')
      end

      it "should render the show page for an admin user" do
        get :show, :id => @admin_user.id
        response.should render_template('show')
      end
    end

    context "an admin user" do
      before do
        @user = FactoryGirl.create(:admin_user)
        @super_admin_user = FactoryGirl.create(:super_admin_user)
        @other_admin = FactoryGirl.create(:admin_user)

        sign_in @user
      end

      it "should render the show page for an admin user" do
        get :show, :id => @other_admin.id
        response.should render_template('show')
      end

      it "should should redirect back to the dashboard index for a super admin user" do
        get :show, :id => @super_admin_user.id
        response.should redirect_to(dashboard_index_path)

      end
    end
  end
end