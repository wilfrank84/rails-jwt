class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, only: [:show, :destroy]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { error: @user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    unless @user.update(user_params)
      render json: { error: @user.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:email, :password, :username)
  end
end
