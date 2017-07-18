class ObtainedSkill < ApplicationRecord
  belongs_to :skill
  belongs_to :character
  belongs_to :applicable_weapon_class, class_name: 'WeaponClass', optional: true

end
