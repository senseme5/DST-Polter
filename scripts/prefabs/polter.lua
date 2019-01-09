local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {}

-- Custom starting inventory
local start_inv = {
}

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when not a ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "polter_speed_mod", 1)
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "polter_speed_mod")
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "polter.tex" )
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "willow"
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(300)
	inst.components.hunger:SetMax(500)
	inst.components.sanity:SetMax(250)
	
	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 2
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 2 * TUNING.WILSON_HUNGER_RATE
	
	inst.components.combat.min_attack_period = 0.2
	
	inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.5)
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.6)
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

return MakePlayerCharacter("polter", prefabs, assets, common_postinit, master_postinit, start_inv)
