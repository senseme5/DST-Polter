PrefabFiles = {
	"polter",
	"polter_none",
	"polterknife",
	"polterpack",
	"polterfoods",
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
	Asset( "IMAGE", "images/map_icons/polterpack.tex" ),
	Asset( "ATLAS", "images/map_icons/polterpack.xml" ),
	
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
AddMinimapAtlas("images/map_icons/polterpack.xml")

modimport "scripts/strings_polter.lua"
modimport "scripts/recipes_polter.lua"

AddModCharacter("polter", "MALE")