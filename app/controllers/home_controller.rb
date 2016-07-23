class HomeController < ApplicationController
  def index
    # all tasks
    @all_tasks = Task.all
    # tasks where current user - author
    if user_signed_in?
      @user_author_tasks = Task.where(author: current_user.email)
      @current_user_tasks = []
      @shared_user_tasks = []
      # All tasks, that shared for current_user in additional table
      @all_user_shared_tasks = TaskUser.where(user_id: current_user.id)
      @all_user_shared_tasks.each do |task_user|
        #  Remove empty tasks for current user in TaskUser table
        if Task.exists?(id: task_user.task_id) == false
          @emptyTask = Task.find_by(id: task_user.task_id)
          TaskUser.where(id: task_user.id).destroy_all
        end
        # Search present tasks
        @findThatTasks = Task.where(id: task_user.task_id)
        @findThatTasks.each do |task|
          @shared_user_tasks << task
        end
      end
      # Combine tasks array
     @current_user_tasks = @user_author_tasks + @shared_user_tasks
    end
  end
end
