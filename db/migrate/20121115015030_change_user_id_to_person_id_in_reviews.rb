class ChangeUserIdToPersonIdInReviews < ActiveRecord::Migration
  def change
    rename_column :reviews, :user_id, :person_id
  end
end
