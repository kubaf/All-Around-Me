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

require 'digest'

# User.create!(first_name: "Kuba", last_name: "FSomething", email: "abc@def.com", password: "foobar", password_confirmation: "foobar")
class User < ActiveRecord::Base
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation

  # Adds authenticate method among other things
  # https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
  has_secure_password
  
  has_many :reviews, dependent: :destroy
  has_many :review_reviewers

  before_save { self.email.downcase! }
  before_save :generate_session_token


  validates :first_name,  :presence=>true,
                          :length => {:maximum =>50}
  validates :last_name,  :presence=>true,
                         :length => {:maximum =>50}

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
                    :format => {:with => email_regex},
                    :uniqueness => {:case_sensitive => false}
                    
  validates :password,  :length => {:within => 6..254}
                        
  validates :password_confirmation, :presence => true
  
                        
  
  def name
    return "#{first_name} #{last_name}"
  end
  
  private
  
    def generate_session_token
      self.session_token = SecureRandom.urlsafe_base64
    end


end
