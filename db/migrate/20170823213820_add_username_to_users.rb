class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_index :users, :username, unique: true
  end
end
