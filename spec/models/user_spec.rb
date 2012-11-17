# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :name => "Example User",
              :email => "foobar@example.com",
              :password => "validpasswd",
              :password_confirmation => "validpasswd" }
  end

  it "should create a user" do
    User.create! @attr
  end

  it "should have a name" do
    u = User.new(@attr.merge :name => "")
    u.should_not be_valid
  end

  it "should have an email" do
    u = User.new(@attr.merge :email => "")
    u.should_not be_valid
  end

  it "should reject names that are too long" do
    u = User.new(@attr.merge :name => ("a" * 51))
    u.should_not be_valid
  end 

  it "should accept valid email addresses" do
    emails = ["javer821@gmail.com", "a@b.com", "499855641@qq.com", "_abc_@qq.com.cn"]
    emails.each do |e|
      u = User.new(@attr.merge :email => e)
      u.should be_valid
    end
  end


  it "should reject invalid email addresses" do
    emails = ["123@@qq.com", "123", "jajaja......", "this is not an email"]
    emails.each do |e|
      u = User.new(@attr.merge :email => e)
      u.should_not be_valid
    end
  end

  it "should keep the emails unique" do
    User.create! @attr
    u = User.new @attr
    u.should_not be_valid

    u = User.new @attr.merge(:email => @attr[:email].upcase)
    u.should_not be_valid
  end

  describe "password validations" do
    it "should require a password" do
      u = User.new @attr.merge(:password => "", :password_confirmation => "")
      u.should_not be_valid
    end

    it "should require password confirm" do
      u = User.new @attr.merge(:password_confirmation => "valid")
      u.should_not be_valid
    end

    it "should reject passwords too long or too short " do
      u = User.new @attr.merge(:password => "a", :password_confirmation => "a")
      u.should_not be_valid

      u = User.new @attr.merge(:password => "a"*51, :password_confirmation => "a"*51)
      u.should_not be_valid
    end
  end

  describe "password encryption" do
    before(:each) do
      @user = User.create! @attr
    end

    it "should have an encrypted password" do
      @user.should respond_to :encrypted_password
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank 
    end

    describe "match_password?" do
      it "should be true if password matches" do
        @user.match_password?(@attr[:password]).should be_true
      end

      it "should be false if password doesn't match" do
        @user.match_password?("wrong password!").should be_false
      end
    end

    describe "authenticate method" do
      it "should return a User object when the password matches" do
        u = User.authenticate(@attr[:email], @attr[:password])
        u.should == @user
      end

      it "should return nil when email or password mismatches" do
        u = User.authenticate(@attr[:email], "12345")
        u.should be_nil
      end
    end

  end
end
