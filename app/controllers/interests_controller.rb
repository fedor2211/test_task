class InterestsController < ApplicationController
  before_action :set_interest, only: %i[ show edit update destroy ]

  def index
    @interests = Interest.all
  end

  def show
  end

  def new
    @interest = Interest.new
  end

  def edit
  end

  def create
    @interest = Interest.new(interest_params)

    if @interest.save
      redirect_to @interest, notice: "Interest was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @interest.update(interest_params)
      redirect_to @interest, notice: "Interest was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @interest.destroy!
    redirect_to interests_path, status: :see_other, notice: "Interest was successfully destroyed."
  end

  private

  def set_interest
    @interest = Interest.find(params.expect(:id))
  end

  def interest_params
    params.fetch(:interest, {}).permit(:name)
  end
end
