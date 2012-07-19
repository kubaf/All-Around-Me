require 'spec_helper'
require 'pp'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }
   
    it { should have_selector('h1',    text: 'Sign Up') }
  end
  
  describe "profile page" do
    let(:user) { Factory.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
  
  describe "signup" do
    before {visit signup_path}
    
    let(:submit) { "Create Account"}
    
    describe "with invalid information" do
      it "should not create a user" do
        expect {click_button submit}.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "First name",     with: "Example"
        fill_in "Last name",      with: "User"
        fill_in "Email",          with: "a@b.net"
        fill_in "Password",       with: "password"
        fill_in "Confirmation",   with: "password"
      end
      
      it "should create a user" do
        expect {click_button submit}.to change(User, :count).by(1)
      end
      
      describe "after creating the user" do
        before {click_button submit}
        let(:user) {User.find_by_email('a@b.net')}
        
        it {should have_selector('title', text: user.name)}
        it {should have_selector('div.alert.alert-success', text: 'registration')}
        it {should have_link('Sign out')}
      end
    end
    
  end
  
  describe "edit" do
    let(:user) {Factory.create(:user)}
    before {visit edit_user_path(user)}
    
    describe "page" do
      it {should have_link('change', href: 'http://gravatar.com/emails')}
    end
    
    describe "with invalid information" do
      before {click_button "Save changes"}
      
      it {should have_content('error')}
    end
    
    
  end

  
end
