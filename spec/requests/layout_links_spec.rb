require 'spec_helper'

describe "LayoutLinks" do
  it "should have a(n) home page" do
    get '/'
	response.should have_selector('title', :content => "Home")
  end

  it "should have a(n) contact page" do
    get '/contact'
	response.should have_selector('title', :content => "Contact")
  end

  it "should have a(n) about page" do
    get '/about'
	response.should have_selector('title', :content => "About")
  end

  it "should have a(n) help page" do
    get '/help'
	response.should have_selector('title', :content => "Help")
  end

  it "should have a(n) sign up page" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end
end
