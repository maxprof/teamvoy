class AddIndexes < ActiveRecord::Migration
  def change
    add_index :task_users, [:task_id]
    add_index :task_users, [:user_id]
    add_index :tasks, [:user_id]
  end
end
