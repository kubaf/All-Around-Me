# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  session_token   :string(255)
#  admin           :boolean          default(FALSE)
#

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
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:authenticate)}
  it {should respond_to(:session_token)}
  it {should respond_to(:admin)}
  it {should respond_to(:reviews)}

  it {should be_valid}   
  it {should_not be_admin}
  
  describe "with admin attribute set to ture" do
    before {@user.toggle!(:admin)}
    it {should be_admin}
  end
     

  describe "session token" do
    before {@user.save}
    its(:session_token) {should_not be_blank}
  end
  
  describe "authenticate method" do
    
    before {@user.save}
    let(:found_user) {User.find_by_email(@user.email)}
    
    describe "with valid password" do
      it {should == found_user.authenticate(@user.password)}
    end
    
    describe "with invalid password" do
      let(:user_for_invalid_password) {found_user.authenticate("invalid")}
      
      it {should_not == user_for_invalid_password}
      specify {user_for_invalid_password.should be_false}
    end
    
    
  end
  
  
  
  
 
  describe "password validations" do
    
    describe "password validations" do

      describe "when password is not present" do
        before {@user.password = @user.password_confirmation = ""}
        it {should_not be_valid}
      end
      
      describe "when password is blank" do
        before {@user.password = @user.password_confirmation = " "}
        it {should_not be_valid}
      end
      
      describe "when password confirmation is nil" do
        before {@user.password_confirmation = nil}
        it {should_not be_valid}
      end

      describe "when password confirmation does not match pasword" do
        before {@user.password_confirmation = "mismatch"}
        it {should_not be_valid}
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
  
  
  describe "review associations" do
    
    before {@user.save}
    let!(:older_review) do
      Factory.create(:review, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_review) do
      Factory.create(:review, user: @user, created_at: 1.hour.ago)
    end
    
    it "should have the right reviews in the right order" do
      @user.reviews.should == [newer_review, older_review]
    end
  end
  
  it "should destroy associated reviews" do
    reviews = @user.reviews
    @user.destroy
    reviews.each do |review|
      Review.find_by_id(review.id).should be_nil
    end
  end
  
end
