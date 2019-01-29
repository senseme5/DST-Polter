local assets =
{
    --Asset("ANIM", "anim/polterpack.zip"),
    --Asset("ANIM", "anim/swap_polterpack.zip"),
	Asset("ANIM", "anim/ui_backpack_2x4.zip"),

    Asset("ATLAS", "images/inventoryimages/polterpack.xml"),
    Asset("IMAGE", "images/inventoryimages/polterpack.tex")
}

local containers = require "containers"	
local slotpos = {}
for y = 0, 3 do
    table.insert(slotpos, Vector3(-162, -75 * y + 114, 0))
    table.insert(slotpos, Vector3(-162 + 75, -75 * y + 114, 0))
end

local polterpack = {
	widget = {
        slotpos = slotpos,
        animbank = "ui_backpack_2x4",
        animbuild = "ui_backpack_2x4",
        pos = Vector3(-5, -70, 0),
    },
    issidewidget = true,
    type = "pack",
}

local _widgetsetup = containers.widgetsetup
function containers.widgetsetup(container, prefab, data, ...)
	if container.inst.prefab == "polterpack" or prefab == "polterpack" then
		data = polterpack
		
		for k,v in pairs(polterpack) do
			container[k] = v
		end
		container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
		return
	else
		return _widgetsetup(container, prefab, data, ...)
	end
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "swap_polterpack", "swap_body")

    if inst.components.container ~= nil then
        inst.components.container:Open(owner)
    end
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    if inst.components.container ~= nil then
		inst.components.container:Close(owner)
    end
end

local function onopen(inst)
   inst.SoundEmitter:PlaySound("dontstarve/wendy/backpack_open", "open")
end

local function onclose(inst)
   inst.SoundEmitter:PlaySound("dontstarve/wendy/backpack_close", "open")
end

local function fn(Sim)
   local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
   
	MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("icepack")
    inst.AnimState:SetBuild("swap_icepack")
    inst.AnimState:PlayAnimation("anim")

    inst.MiniMapEntity:SetIcon("icepack.png")
    inst:AddTag("backpack")
    inst:AddTag("fridge")
    inst:AddTag("nocool")

    inst.foleysound = "dontstarve/movement/foley/backpack"

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("inspectable")
	
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("polterpack", polterpack)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.cangoincontainer = false
    inst.components.inventoryitem.imagename = "polterpack"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/polterpack.xml"
    
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    
	inst:AddComponent("equippable")
	inst.components.equippable.keepondeath = false
	inst.components.equippable.equipslot = EQUIPSLOTS.BODY
	-- 가방을 떨어뜨리게 합니다.
   
	if EQUIPSLOTS.PACK ~= nil then
		inst.components.equippable.equipslot = EQUIPSLOTS.PACK
	elseif EQUIPSLOTS.BACK ~= nil then
		inst.components.equippable.equipslot = EQUIPSLOTS.BACK
	else
		inst.components.equippable.equipslot = EQUIPSLOTS.BODY
	end
   
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
   
	MakeHauntableLaunchAndDropFirstItem(inst)
    
    return inst
end

return Prefab( "common/inventory/polterpack", fn, assets) 