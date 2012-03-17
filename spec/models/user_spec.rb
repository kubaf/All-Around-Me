require 'spec_helper'

describe User do

  before(:each) do
    @attr = {:first_name => "First", :last_name => "Last", :email => "user@example.com"}
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a last name" do
    no_name_user = User.new(@attr.merge(:last_name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_first_name = "a" * 51
    long_last_name = "b" * 52
    
    long_name_user = User.new(@attr.merge(:first_name => long_first_name, :last_name => long_last_name))
    long_name_user.should_not be_valid
  end
  
  it "should reject invalid email addresses" do
    emails = %w[user@foo,com user_at_foo_.org example.user@foo]
    emails.each do |email|
      invalid_email_user = User.new(@attr.merge(:email => email))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
end
