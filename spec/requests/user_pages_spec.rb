require 'spec_helper'
require 'pp'

describe "User pages" do

  subject { page }
  
  describe "index" do
    
    let(:user) { Factory.create(:user) }
    
    before(:all) { 30.times {Factory.create(:user)}}
    after(:all) { User.delete_all}
    
    before(:each) do
      sign_in user
      visit users_path
    end
    
    it {should have_selector('title', text: "All users")}
    
    describe "pagination" do
      it {should have_selector('div.pagination')}
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end
    
    describe "delete links" do
      
      it {should_not have_link('delete')}
      
      describe "as an admin user" do
        let(:admin) {Factory.create(:admin)}
        before do
          sign_in admin
          visit users_path
        end
        
        it {should have_link('delete', href: user_path(User.first))}
        it "should be able to delete another user" do
          expect {click_link('delete')}.to change(User, :count).by(-1)
        end
        it {should_not have_link('delete', href: user_path(admin))}
      end
    end
  end

  describe "registration page" do
    before { visit register_path }
   
    it { should have_selector('h1',    text: 'Register') }
  end
  
  
  
  
  
  describe "profile page" do
    let(:user) { Factory.create(:user) }
    let!(:r1) {Factory.create(:review, user: user, name: "review1")}
    let!(:r2) {Factory.create(:review, user: user, name: "review2")}
    
    
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
    
    describe "reviews" do
      it {should have_content(r1.name)}
      it {should have_content(r2.name)}
    end
    
    
  end
  
  
  
  
  
  describe "register" do
    before {visit register_path}
    
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
        fill_in "Confirm Password",   with: "password"
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
    before do 
      sign_in user
      visit edit_user_path(user)
    end
    
    describe "page" do
      it {should have_link('change', href: 'http://gravatar.com/emails')}
    end
    
    describe "with invalid information" do
      before {click_button "Save changes"}
      
      it {should have_content('error')}
    end
    
    describe "with valid information" do
      let(:new_first_name) {"New First Name"}
      let(:new_last_name) {"New Last Name"}
      let(:new_email) {"new@email.com"}
      
      before do
        fill_in "First name",    with: new_first_name
        fill_in "Last name",     with: new_last_name
        fill_in "Email",         with: new_email
        fill_in "Password",      with: user.password
        fill_in "Confirm Password",  with: user.password
        click_button "Save changes"
      end
      
      it {should have_selector('div.alert.alert-success')}
      it {should have_link('Sign out', href: signout_path)}
      specify {user.reload.first_name.should == new_first_name}
      specify {user.reload.last_name.should == new_last_name}
      specify {user.reload.email.should == new_email}
    end

  end
  
end
