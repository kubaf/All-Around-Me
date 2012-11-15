class Person < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  
  before_save :downcase_email
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
                    :format => {:with => email_regex},
                    :uniqueness => {:case_sensitive => false}
  
  
  def name
    return "#{first_name} #{last_name}"
  end
  
  def registered?
    return !type.nil?
  end
  
  private
    def downcase_email
      self.email.downcase!
    end
  
end
