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

require 'spec_helper'

describe Reviewer do
  pending "add some examples to (or delete) #{__FILE__}"
end
