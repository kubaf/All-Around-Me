class AddDurationToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :duration, :timestamp
  end
end
