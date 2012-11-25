require 'spec_helper'

describe SessionsController do
  render_views
  describe "Sign In" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "has right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign in")
    end
  end

  describe "Post 'create'" do
    describe "Invalid sign in" do
      before(:each) do
        @attr = { :email => "javer821@gmail.com", :password => "Haha" }
      end

      it "renders sign page" do
        post :create, :session => @attr
        response.should render_template('new')
      end

      it "should have a flash message" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end
    end

    describe "Successful signing in" do
      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end

      it "should redirect to profile page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end

      it "should keep signed in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end
    end
  end

  describe "DELETE 'destroy'" do
    
    before(:each) do
      controller.sign_in Factory(:user)
    end
    it "should sign a user out" do
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end
end
