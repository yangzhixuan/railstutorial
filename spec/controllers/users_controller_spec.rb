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
end
