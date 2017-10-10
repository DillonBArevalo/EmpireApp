class ObtainedSkillsController < ApplicationController
  def create
    obtain_skill
  end

  def update
    obtain_skill
  end

  private

  def obtain_skill
    @character = Character.find(params[:character_id])
    auth(@character)
    @skill = Skill.find(params[:skill_id])
    @character.obtain_skill(@skill)
    redirect_to @skill
  end
end
