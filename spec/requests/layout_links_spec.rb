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
  
  it "should have right links on the home page" do
    def check_link(str, title="")
      click_link str
      response.should have_selector('title', :content => (title.empty?) ? str : title)
    end
    visit root_path
    check_link "About" 
    check_link "Help" 
    check_link "Contact" 
  end
end
