# Notes

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
- maybe have some kind of character/equipment liking system?
- Note that currently equipped weapons are included in inventory!


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
- depending on what I want the user page to look like i might have to add more associations to it. Might need things like inventories, weapons used, classes used, etc. stats things

## Random notes:

- decided on adding energy boosts upon getting more skill points, not upon getting more skills!

- maybe make skill costs a json on skills to cut down on db lookups?

- look into what's cascading for deletion. does deleting a character kill all the equipped stuff? that would be bad. conversely, does it not destroy the equipped things tables? either way it's bad... look into it for non mvp unless serious bug
