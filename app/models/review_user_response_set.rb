class ReviewUserResponseSet < ActiveRecord::Base
  attr_accessible :completed_at, :person_id, :review_id, :started_at
end
