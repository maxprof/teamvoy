class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :check_rules, only: [:edit, :update, :destroy]
  def index
    @tasks = Task.all
  end

  def show
    if user_signed_in?
      check_tag_users
    end
  end

  def new
    @task = Task.new
    if !user_signed_in?
      flash[:danger] = "You are not signed in"
      redirect_to root_path
    end
  end

  def create
    @task = Task.new(task_params)
    @task.author = current_user.email
      respond_to do |format|
        if @task.save
          format.html { redirect_to @task, notice: 'Task was successfully created.' }
          format.json { render :show, status: :created, location: @task }
          format.js
        else
          format.html { render :new }
          format.json { render json: @task.errors, status: :unprocessable_entity }
          format.js
        end
      end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = "Task was successufly updated"
      redirect_to task_path(@task)
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to root_path, flash[:success] = "Task was successufly destroyed" }
      format.json { head :no_content}
    end
  end

  private

    def check_tag_users
      @task_users = TaskUser.find_by(user_id: current_user.id, task_id: @task.id)
    end

    def check_rules
      if user_signed_in?
        @user = current_user
        if @task.user_id != @user.id && @task_users != nil
          flash[:danger] = "It's not your task"
          redirect_to tasks_path
        end
      else
        flash[:danger] = "You dont signed in to do this operation"
        redirect_to tasks_path
      end
    end

    def set_task
      @task = Task.find_by_id(params[:id])
    end

    def task_params
       params.require(:task).permit(:title, :description, :user_id, :author, user_ids: [])
    end
end
