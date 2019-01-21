local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {}

local start_inv = {
	"polterknife"
}

local common_postinit = function(inst) 
	inst.MiniMapEntity:SetIcon( "polter.tex" )
end

local master_postinit = function(inst)
	inst.soundsname = "willow"
	inst.starting_inventory = start_inv

	inst.components.health:SetMaxHealth(300)
	inst.components.hunger:SetMax(500)
	inst.components.hunger:SetKillRate(10) -- 배고픔 0일때 체력이 1초에 10씩닳는다.
	inst.components.hunger.hungerrate = 2 * TUNING.WILSON_HUNGER_RATE
	inst.components.sanity:SetMax(250)
	
    inst.components.combat.damagemultiplier = 2
	inst.components.combat.min_attack_period = 0.2
	
	inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.5)
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.6)
	
end

return MakePlayerCharacter("polter", prefabs, assets, common_postinit, master_postinit)
