local assets =
{
    Asset("ANIM", "anim/polterknife.zip"),
    Asset("ANIM", "anim/swap_polterknife.zip"),
	Asset("ATLAS", "images/inventoryimages/polterknife.xml"),
	Asset("IMAGE", "images/inventoryimages/polterknife.tex" ),
}

local function UpdateDamage(inst)
    if inst.components.perishable and inst.components.weapon then
        local dmg = TUNING.HAMBAT_DAMAGE * inst.components.perishable:GetPercent()
        dmg = Remap(dmg, 0, TUNING.HAMBAT_DAMAGE, TUNING.HAMBAT_MIN_DAMAGE_MODIFIER*TUNING.HAMBAT_DAMAGE, TUNING.HAMBAT_DAMAGE)
        inst.components.weapon:SetDamage(dmg)
    end
end

local function OnLoad(inst, data)
    UpdateDamage(inst)
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_polterknife", "swap")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("polterknife")
    inst.AnimState:SetBuild("polterknife")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.HAMBAT_DAMAGE)
    --inst.components.weapon:SetOnAttack(UpdateDamage)

    --inst.OnLoad = OnLoad

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/polterknife.xml"
	inst.components.inventoryitem.imagename = "polterknife"
	
    MakeHauntableLaunch(inst)

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    return inst
end

return Prefab( "polterweapon", fn, assets) 