local assets =
{
	Asset( "ANIM", "anim/polter.zip" ),
	Asset( "ANIM", "anim/ghost_polter_build.zip" ),
}

local skins =
{
	normal_skin = "polter",
	ghost_skin = "ghost_polter_build",
}

return CreatePrefabSkin("polter_none",
{
	base_prefab = "polter",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"POLTER", "CHARACTER", "BASE"},
	build_name = "polter",
	rarity = "Common",
})