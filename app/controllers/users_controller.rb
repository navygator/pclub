class UsersController < ApplicationController
  before_action :load_resource
  before_action :check_user, only: [:edit, :update, :destroy]
  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
    if @resource.present? && @resource.update_attributes(user_params)
      redirect_to users_path, notice: "Successfuly update user"
    else
      flash[:alert] = "Can't update user"
      render 'edit'
    end
  end

  def destroy
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :name)
  end
  
  def load_resource
    if params[:action] == 'index'
      @collection = User.all
    else
      @resource = User.find(params[:id])
    end
  end
  
  def check_user
    redirect_to users_path, alert: "Access denied!" if current_user != @resource
  end
end
