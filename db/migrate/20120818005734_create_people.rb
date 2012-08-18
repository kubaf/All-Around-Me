class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :password_digest
      t.string :session_token
      t.integer :admin
      t.string :type

      t.timestamps
    end
  end
end
