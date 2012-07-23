class Review < ActiveRecord::Base
  attr_accessible :name, :status
  
  belongs_to :user
  
  validates :user_id, presence: true
end
