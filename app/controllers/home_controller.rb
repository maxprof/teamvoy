class HomeController < ApplicationController
  def index
    @task = Task.new
    check_users_tasks
  end
end
