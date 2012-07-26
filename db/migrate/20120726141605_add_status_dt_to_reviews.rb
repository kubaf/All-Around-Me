class AddStatusDtToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :status_dt, :timestamp
  end
end
