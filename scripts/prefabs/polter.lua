local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}

local prefabs = {}

local start_inv = {
	"polterweapon"
}

local function CombatTweak(inst)
	local self = inst.components.combat
	local _DoAttack = self.DoAttack

	inst.components.combat.DoAttack = function(inst, targ, weapon, projectile, stimuli, instancemult)
		if targ == nil then
			targ = self.target
		end
		if weapon == nil then
			weapon = self:GetWeapon()
		end
		if stimuli == nil and weapon ~= nil and weapon.components.weapon ~= nil and weapon.components.weapon.overridestimulifn ~= nil then
			stimuli = weapon.components.weapon.overridestimulifn(weapon, self.inst, targ)
		end
		
		if targ ~= nil then
			if targ.prefab == "pigman" then
				instancemult = 2
			elseif targ:HasTag("catcoon") then
				instancemult = 0.1
			end
		end

		_DoAttack(inst, targ, weapon, projectile, stimuli, instancemult)
	end
end

local common_postinit = function(inst) 
	inst.MiniMapEntity:SetIcon( "polter.tex" )
end

local master_postinit = function(inst)
	inst.soundsname = "wilson"
	inst.starting_inventory = start_inv

	inst.components.health:SetMaxHealth(300)
	inst.components.hunger:SetMax(500)
	inst.components.hunger:SetRate(2 * TUNING.WILSON_HUNGER_RATE)
	inst.components.hunger:SetKillRate(10) -- 배고픔 0일때 체력이 1초에 10씩닳는다.
	inst.components.sanity:SetMax(250)
	
    inst.components.combat.damagemultiplier = 2
	inst.components.combat.min_attack_period = 0.2
	CombatTweak(inst)
	
	inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.5)
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.6)
end

return MakePlayerCharacter("polter", prefabs, assets, common_postinit, master_postinit)
