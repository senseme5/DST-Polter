local foods = {
	candy = {
		foodtype = FOODTYPE.VEGGIE,
		health = 0,
		hunger = TUNING.CALORIES_TINY * 5,
		sanity = 0,
		perishtime = TUNING.TOTAL_DAY_TIME * 22,
	},

	candy_d = {
		foodtype = FOODTYPE.VEGGIE,
		health = 0,
		hunger = TUNING.CALORIES_TINY * 5,
		sanity = 0,
		perishtime = TUNING.TOTAL_DAY_TIME * 22,
	},

	chip = {
		foodtype = FOODTYPE.MEAT,
		health = math.huge,
		hunger = math.huge,
		sanity = math.huge,
		perishtime = TUNING.TOTAL_DAY_TIME * 222,
	},
}

for k, v in pairs(foods) do
	v.name = k
end

local prefabs = {
	"spoiled_food",
}

local function MakePolterFood(data)
	local pref = "polter"..data.name
	local fname = pref:gsub("_d", "")

	local assets = {
		Asset("ANIM", "anim/"..fname..".zip"),
		Asset("ATLAS", "images/inventoryimages/"..fname..".xml"),
		Asset("IMAGE", "images/inventoryimages/"..fname..".tex"),
	}

	local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBuild(fname)
        inst.AnimState:SetBank(fname)
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag("polterfood")
		inst:AddTag("preparedfood")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("edible")
        inst.components.edible.healthvalue = data.health
        inst.components.edible.hungervalue = data.hunger
        inst.components.edible.foodtype = data.foodtype or FOODTYPE.GENERIC
        inst.components.edible.sanityvalue = data.sanity or 0
        inst.components.edible.temperaturedelta = data.temperature or 0
        inst.components.edible.temperatureduration = data.temperatureduration or 0
        inst.components.edible:SetOnEatenFn(data.oneatenfn)

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.imagename = fname
		inst.components.inventoryitem.atlasname = "images/inventoryimages/"..fname..".xml"

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
			
		if data.perishtime ~= nil and data.perishtime > 0 then
			inst:AddComponent("perishable")
			inst.components.perishable:SetPerishTime(data.perishtime)
			inst.components.perishable:StartPerishing()
			inst.components.perishable.onperishreplacement = "spoiled_food"
		end
		
        MakeSmallBurnable(inst)
        MakeSmallPropagator(inst)
        MakeHauntableLaunchAndPerish(inst)

        inst:AddComponent("bait")
        inst:AddComponent("tradable")

        return inst
    end

    return Prefab(pref, fn, assets)
end

local prefs = {}

for k,v in pairs(foods) do
    table.insert(prefs, MakePolterFood(v))
end

return unpack(prefs)