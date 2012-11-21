require 'spec_helper'

describe "Users" do
  describe "Sign up" do
    describe "failure" do
      it "should have an error message and should not change the User model" do
        lambda do
          visit signup_path
          click_button
          response.should render_template('users/new')
          response.should have_selector('div#error_explaination')
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name", :with => "Example"
          fill_in "Email", :with => "foobar@example.com"
          fill_in "Password", :with => "123456"
          fill_in "Password Confirmation", :with => "123456"
          click_button
          response.should have_selector("div.flash.success", :content => "Welcome")
          response.should render_template("users/show")
        end.should change(User, :count).by(1)
      end
    end
  end
end
