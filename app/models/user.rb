
# For password stuff
require 'digest'

class User < Person
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation

  # Adds authenticate method among other things
  # https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
  has_secure_password
  
  has_many :reviews, dependent: :destroy
  
  has_many :review_reviewers

  
  before_save :generate_session_token


  validates :first_name,  :presence=>true,
                          :length => {:maximum =>50}
  validates :last_name,  :presence=>true,
                         :length => {:maximum =>50}

  
                    
  validates :password,  :length => {:within => 6..254}
                        
  validates :password_confirmation, :presence => true
  
  
  private
  
    def generate_session_token
      self.session_token = SecureRandom.urlsafe_base64
    end


end
