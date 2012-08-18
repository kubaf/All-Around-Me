class Person < ActiveRecord::Base
  attr_accessible :admin, :email, :first_name, :last_name, :password, :password_digest, :session_token, :type
  
  
  def name
    return "#{first_name} #{last_name}"
  end
end
