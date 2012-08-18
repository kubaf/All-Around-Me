class AddEmailUniquenessIndexToPeople < ActiveRecord::Migration
  def self.up
    add_index :people, :email, :unique => true
  end

  def self.down
    remove_index :people, :email
  end
end
