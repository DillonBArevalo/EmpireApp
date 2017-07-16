# Notes


## Virtual stats for characters:

- maybe use after_initialize (which runs after finding a thing as well) to create virtual stats
- stat die sizes


## Schema is missing:

- Ranged Weapons/ranger
- dodge
- shield bashing rules maybe?
- juggernaut skills
- non combat based stats (height, age, weight, etc.)
- inventory limitations?

## Thoughts:

- Maybe a tags table for easy searching?
- When the game is playable have a fight response form that sends information on how the characters felt/feedback
- also have a db of results from fights pointing to characters that competed and results.
- maybe have a whole statistics resource with searching (ransack?)


## skill stat categories:

A LOT OF THESE DON'T MATTER FOR JUST THE CHARACTER CREATOR. ONLY PASSIVE STAT BOOSTS MATTER (PLUS DESCRIPTIONS)
- damage increase for only one weapon class (yes)
- damage die increase for only one weapon class (yes)
- stacks (temp) (no)
- energy budget (currently no)
- base damage over anything (currently no)
- possible attacks available (yes)
- possible blocks available (yes)
- accuracy increase for only one weapon class (yes)
- boolean for whether to include the desc in character base profile (final rush yes, static increases, no)
- tactical maneuver dex die bonus (yes)
- def with a shield (yes)
- die size increase with a shield (yes)
- bonus to base armor def (yes)

## For models:

- add dependent true to associations? Think through which ones

