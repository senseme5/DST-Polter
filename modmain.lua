PrefabFiles = {
	"polter",
	"polter_none",
	"polterknife",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/polter.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/polter.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/polter.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/polter.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/polter_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/polter_silho.xml" ),

    Asset( "IMAGE", "bigportraits/polter.tex" ),
    Asset( "ATLAS", "bigportraits/polter.xml" ),
	
	Asset( "IMAGE", "images/map_icons/polter.tex" ),
	Asset( "ATLAS", "images/map_icons/polter.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_polter.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_polter.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_polter.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_polter.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_polter.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_polter.xml" ),
	
	Asset( "IMAGE", "images/names_polter.tex" ),
    Asset( "ATLAS", "images/names_polter.xml" ),
	
	Asset( "IMAGE", "images/names_gold_polter.tex" ),
    Asset( "ATLAS", "images/names_gold_polter.xml" ),
	
    Asset( "IMAGE", "bigportraits/polter_none.tex" ),
    Asset( "ATLAS", "bigportraits/polter_none.xml" ),

}

AddMinimapAtlas("images/map_icons/polter.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.polter = "The insincerity butcher"
STRINGS.CHARACTER_NAMES.polter = "Esc"
STRINGS.CHARACTER_DESCRIPTIONS.polter = "*Perk 1\n*Perk 2\n*Perk 3"
STRINGS.CHARACTER_QUOTES.polter = "\"I'm Looking for a GOOD WAY TO DIE\""

-- Custom speech strings
STRINGS.CHARACTERS.POLTER = require "speech_polter"

STRINGS.NAMES.POLTERWEAPON = "Polter's weapon"
STRINGS.CHARACTERS.POLTER.DESCRIBE.POLTERWEAPON = "It's MINE"

-- The character's name as appears in-game 
STRINGS.NAMES.POLTER = "Esc"

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("polter", "MALE")