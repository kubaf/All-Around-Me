require 'spec_helper'

describe Person do
  
  before(:each) do
    @attr = {
      :first_name => "First", 
      :last_name => "Last", 
      :email => "user@example.com",
      }
    @person = Person.create!(@attr)
  end
  
  subject {@person}
  
  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:first_name)}
  it {should respond_to(:last_name)}

  it {should be_valid}   
  
  
end
