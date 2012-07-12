require 'digest'

# User.create!(first_name: "Kuba", last_name: "FSomething", email: "abc@def.com", password: "foobar", password_confirmation: "foobar")
class User < ActiveRecord::Base
  
  attr_accessible :first_name, :last_name, :email, :admin, :password, :password_confirmation

  # Adds authenticate method among other things
  # https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
  has_secure_password

  before_save { |user| user.email = email.downcase }


  validates :first_name,  :presence=>true,
                          :length => {:maximum =>50}
  validates :last_name,  :presence=>true,
                         :length => {:maximum =>50}

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
                    :format => {:with => email_regex},
                    :uniqueness => {:case_sensitive => false}
                    
  validates :password,  :presence => true,
                        :length => {:within => 6..254}
                        
  validates :password_confirmation, :presence => true
  
                        
  
  def name
    return "#{first_name} #{last_name}"
  end


end
