# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :name => "Example User", :email => "foobar@example.com" }
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

end
