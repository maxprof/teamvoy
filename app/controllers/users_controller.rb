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
    check_users_tasks
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
       params.require(:user).permit(:email, :login)
    end
end



