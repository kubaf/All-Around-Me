class AddSessionTokenIndexToPeople < ActiveRecord::Migration
  def self.up
    add_index :people, :session_token
  end

  def self.down
    remove_index :people, :session_token
  end
end
