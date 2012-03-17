class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email

  validates :first_name,  :presence=>true,
                          :length => {:maximum =>50}
  validates :last_name,  :presence=>true,
                         :length => {:maximum =>50}

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
                    :format => {:with => email_regex},
                    :uniqueness => true
end
