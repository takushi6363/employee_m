class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    User.create(user_params)
    redirect_to master_index_path
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:address,:birthday,:phone_number,:phone_number_2,:joining_day,:my_number,:working_days_id)
  end

end


