require 'spec_helper'

describe DashboardController do
  context "user is not logged in" do
    it "should get redirected to the login page" do
      get :index
      response.should redirect_to(new_user_session_path)
    end
  end

  context "user is logged in" do
    context "non-banned user" do
      let(:user) { FactoryGirl.create(:staff_user ) }

      before do
        sign_in user
      end

      it "should show the dashboard" do
        get :index
        response.should render_template("index")
      end
    end

    context "banned user" do
      let(:user) { FactoryGirl.create(:banned_user) }

      before do
        sign_in user
      end

      it "should redirect back to the login page" do
        get :index
        flash[:alert].should =~ /suspended/
        response.should redirect_to(new_user_session_path)
      end
    end

  end
end