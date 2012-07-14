require 'spec_helper'
require 'pp'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }
   
    it { should have_selector('h1',    text: 'Sign Up') }
  end
end
