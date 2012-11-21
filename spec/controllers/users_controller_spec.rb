require 'spec_helper'

describe UsersController do

  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "has right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end
  end


  describe "Get 'show'" do
    before(:each) do
      @user = Factory.create(:user)
    end

    it "returns http success" do
      get 'show', :id => @user.id
      response.should be_success
    end

    it "finds right user" do
      get 'show', :id => @user.id
      assigns(:user).should == @user
    end

    it "has right title" do
      get 'show', :id => @user
      response.should have_selector("title", :content => @user.name)
    end

    it "has right content" do
      get 'show', :id => @user
      response.should have_selector("h1", :content => @user.name) 
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = { :name => "", :email => "", :password => "",
                  :password_confirmation => ""}
      end

      it "succeeds" do
        post 'create', @attr
        response.should be_success 
      end

      it "should not create a user" do
        lambda { post 'create', :user => @attr }.should_not change(User, :count)
      end

      it "should render new page" do
        post 'create', @attr
        response.should render_template('new')
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :name => "Foo", :email => "foobar@yangzx.com", 
                  :password => "123456789", :password_confirmation => "123456789" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to profile page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
    end
  end
end
