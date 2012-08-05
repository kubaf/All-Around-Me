class Reviewer < ActiveRecord::Base
  attr_accessible :relationship, :review_id, :user_id
end
