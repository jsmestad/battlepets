class UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.create(user_params)

    if @user.persisted?
      render json: @user, status: :created
    else
      render json: {errors: @user.errors.messages}, status: :bad_request
    end
  end

private

  def user_params
    params.require(:user).permit(:email)
  end
end
