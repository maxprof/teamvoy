class RemoveUsersFields < ActiveRecord::Migration
  def change
    remove_column :users, :country
    remove_column :users, :date_of_birth
    remove_column :users, :city
    remove_column :users, :address
    remove_column :users, :role
    remove_column :users, :avatar
  end
end
