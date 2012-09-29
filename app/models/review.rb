# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  status     :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status_dt  :datetime
#  duration   :integer
#

class Review < ActiveRecord::Base
  attr_accessible :name, :status, :status_dt, :duration, :created_at, :review_reviewers_attributes
  
  # This is the user who is being reviewed
  belongs_to :user
  
  
  has_many :review_reviewers, :dependent => :destroy
  has_many :reviewers, :through=>:review_reviewers,:source=>:reviewer, :dependent=>:destroy
  
  
  accepts_nested_attributes_for :reviewers, :allow_destroy => true
  accepts_nested_attributes_for :review_reviewers, :allow_destroy => true
  
  validates_associated :review_reviewers
  
  
  
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
