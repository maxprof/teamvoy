class HomeController < ApplicationController
  def index
    check_users_tasks
  end
end
