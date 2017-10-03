class ObtainedSkillsController < ApplicationController
  def create
    @character = Character.find(params[:character_id])
    @skill = Skill.find(params[:skill_id])
    @character.obtain_skill(@skill)
    redirect_to @skill
  end

  def update
    @character = Character.find(params[:character_id])
    @skill = Skill.find(params[:skill_id])
    @character.obtain_skill(@skill)
    redirect_to @skill
  end
end
