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
      visit root_path
      click_link str
      response.should have_selector('title', :content => (title.empty?) ? str : title)
    end
    check_link "About" 
    check_link "Help" 
    check_link "Contact" 
  end

  describe "when not signed in" do
    it "should have a sign in link" do
      visit root_path
      response.should have_selector("a", :href => signin_path)
   end 
  end

  describe "when signed in" do
    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email, :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end

    it "should have a sign out link" do
      visit root_path
      response.should have_selector("a", :href => signout_path)
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user))
    end
  end
end
