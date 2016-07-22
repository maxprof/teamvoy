class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User was successufly created"
      redirect_to(:back)
    else
      render 'new'
    end
  end

  def show
    @tasks = TaskUser.where(user_id: current_user.id)
    @current_user_tasks = []
    @tasks.each do |task|
      @current_user_task_test = Task.where(id: task.task_id)
      @current_user_tasks << @current_user_task_test
      # @current_user_tasks << Task.where(id: task.task_id)
    end
    @current_user_tasks
    @myTasks = Task.where(user_id: current_user.id)
    if @myTasks.empty? ||@current_user_tasks.empty?
      flash[:warning] = "You don't have tasks"
      redirect_to(:back)
    end
  end

  def edit
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "User profile was successufly updated"
      redirect_to user_path(@user)
    end
  end

  def index
    @users = User.all.order('created_at DESC')
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
       params.require(:user).permit(:email, :avatar, :login, :country, :date_of_birth, :city, :address, :role)
    end
end



