class Review < ActiveRecord::Base
  attr_accessible :name, :status, :status_dt, :duration, :created_at
  
  belongs_to :user
  
  validates :user_id, presence: true
  
  default_scope order: 'reviews.created_at DESC'
  
  def active?
    return status == "active"
  end
  
  def expiry
    if active?
      status_dt + (duration ? duration : 14).days
    end
  end
  
end
