class ChangeDurationDatatypeInReviews < ActiveRecord::Migration
  def change
    change_column :reviews, :duration, :integer
  end
end
