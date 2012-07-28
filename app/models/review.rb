class Review < ActiveRecord::Base
  attr_accessible :name, :status, :status_dt, :duration, :created_at
  
  belongs_to :user
  
  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 50}
  validates :duration, presence: true
  validates_numericality_of :duration, only_integer: true, message: "can only be a whole number"
  validates_inclusion_of :duration, in: 1..31, message: "can only be between 1 and 31 days"

  
  
  default_scope order: 'reviews.created_at DESC'
  
  def active?
    return status == "active"
  end
  
  def expiry
    if active?
      status_dt + (duration ? duration : 14).days
    end
  end
  
  def update_status(to)
    self.status = to
    self.status_dt = Time.now
  end

  
end
