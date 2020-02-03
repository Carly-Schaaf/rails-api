class ChangeUsersTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :type
    add_column :users, :user_type, :string, null: false
  end
end
