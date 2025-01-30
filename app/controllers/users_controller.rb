class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
    @user = Users::Update.new(user: @user)
  end

  def create
    outcome = Users::Create.run(user_params)
    if outcome.valid?
      redirect_to outcome.result, notice: "User was successfully created."
    else
      @user = outcome
      render :new, status: :unprocessable_entity
    end
  end

  def update
    outcome = Users::Update.run(user_params.merge(user: @user))
    if outcome.valid?
      redirect_to outcome.result, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to users_path, status: :see_other, notice: "User was successfully destroyed."
  end

  private

  def set_user
    @user = User.find(params.expect(:id))
  end

  def user_params
    params.fetch(:user, {})
  end
end
