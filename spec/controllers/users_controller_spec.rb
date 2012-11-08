require 'spec_helper'

describe UsersController do

  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "Get 'new'" do
    it "has right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end
  end

end
