class Review < ActiveRecord::Base
  attr_accessible :name, :status, :created_at
  
  belongs_to :user
  
  validates :user_id, presence: true
  
  default_scope order: 'reviews.created_at DESC'
end
