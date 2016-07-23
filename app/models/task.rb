class Task < ActiveRecord::Base
  has_many :task_users
  has_many :users, through: :task_users
  delegate :login,:email, :avatar, :to => :user, :prefix => true
  validates :title, presence: true, length: { minimum: 5, maximum: 30 }
  validates :description, presence: true, length: { minimum: 20 }

end
