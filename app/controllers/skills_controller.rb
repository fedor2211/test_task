class SkillsController < ApplicationController
  before_action :set_skill, only: %i[ show edit update destroy ]

  def index
    @skills = Skill.all
  end

  def show
  end

  def new
    @skill = Skill.new
  end

  def edit
  end

  def create
    @skill = Skill.new(skill_params)

    if @skill.save
      redirect_to @skill, notice: "Skill was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @skill.update(skill_params)
      redirect_to @skill, notice: "Skill was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @skill.destroy!
    redirect_to skills_path, status: :see_other, notice: "Skill was successfully destroyed."
  end

  private

  def set_skill
    @skill = Skill.find(params.expect(:id))
  end

  def skill_params
    params.fetch(:skill, {}).permit(:name)
  end
end
