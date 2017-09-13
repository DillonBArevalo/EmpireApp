class SkillsController < ApplicationController

  def index
    @character_classes = CharacterClass.all
    @weapon_classes = WeaponClass.all
  end

  def show
    @skill = Skill.find(params[:id])
    @obtained_skill = ObtainedSkill.new
    if logged_in?
      @characters_skills = current_user.characters.map do |character|
        join = character.obtained_skills.find_by(skill_id: params[:id])
        [character, join, character.skill_obtainable(@skill, join), @skill.cost_at_rank(join ? join.ranks + 1 : 1)]
      end
    end
  end
end
