# == Schema Information
#
# Table name: reviewers
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  review_id    :integer
#  relationship :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Reviewer < ActiveRecord::Base
  attr_accessible :relationship, :review_id, :user_id
end
