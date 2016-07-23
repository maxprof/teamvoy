class Task < ActiveRecord::Base
  has_many :task_users
  has_many :users, through: :task_users
  delegate :login,:email, :avatar, :to => :user, :prefix => true

end
