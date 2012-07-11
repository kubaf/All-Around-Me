require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :first_name => "First", 
      :last_name => "Last", 
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
      }
    @user = User.create!(@attr)
  end
  
  subject {@user}
  
  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:first_name)}
  it {should respond_to(:last_name)}
  it {should respond_to(:encrypted_password)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:authenticate)}

  it {should be_valid}    

  
  
  describe "authenticate method" do
    
    it "should return nil on email/password mismatch" do
      wrong_password_user = User.authenticate(@attr[:email], "wrong password")
      wrong_password_user.should be_nil
    end
    
    it "should return nil for an email address with no user" do
      nonexistent_user = User.authenticate("random@email.com",@attr[:password])
      nonexistent_user.should be_nil
    end
    
    it "should return the user on email/password match" do
      matching_user = User.authenticate(@attr[:email], @attr[:password])
      matching_user.should == @user
    end
    
  end
  
  
  
  
 
  describe "password validations" do
    
    describe "password validations" do

      it "should require a password" do
        User.new(@attr.merge(:password => "", :password_confirmation => "")).
          should_not be_valid
      end
      
      describe "when password is blank" do
        before {@user.password = @user.password_confirmation = " "}
        it {should_not be_valid}
      end
      
      describe "when password confirmation is nil" do
        before {@user.password_confirmation = nil}
        it {should_not be_valid}
      end

      it "should require a matching password confirmation" do
        User.new(@attr.merge(:password_confirmation => "invalid")).
          should_not be_valid
      end

      it "should reject short passwords" do
        short = "a" * 5
        hash = @attr.merge(:password => short, :password_confirmation => short)
        User.new(hash).should_not be_valid
      end

      it "should reject long passwords" do
        long = "a" * 255
        hash = @attr.merge(:password => long, :password_confirmation => long)
        User.new(hash).should_not be_valid
      end
    end
    
    
  end
  

 
  
  describe "user validations" do
    
    it "should require a last name" do
      no_name_user = User.new(@attr.merge(:last_name => ""))
      no_name_user.should_not be_valid
    end
  
  
    describe "when email not present" do
      before {@user.email = ""}
      it { should_not be_valid}
    end
  
    # Alternative test
    #it "should require an email address" do
      #no_email_user = User.new(@attr.merge(:email => ""))
      #no_email_user.should_not be_valid   
    #end
  
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
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end
  end
  
end
