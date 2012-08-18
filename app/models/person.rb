class Person < ActiveRecord::Base
  attr_accessible :admin, :email, :first_name, :last_name, :password, :password_digest, :session_token, :type
  
  before_save { self.email.downcase! }
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
                    :format => {:with => email_regex},
                    :uniqueness => {:case_sensitive => false}
  
  def name
    return "#{first_name} #{last_name}"
  end
end
