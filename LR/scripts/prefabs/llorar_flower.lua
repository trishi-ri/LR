local assets =
{
    Asset("ANIM", "anim/llorar_flower.zip"),
		
}

local prefabs =
{
    "flower",
    "small_puff",
}

-- abigail flower
-- amulet redgem
-- reviver

local function getstatus(inst)
    local prc_fuel=inst.components.fueled:GetPercent()
	
	if prc_fuel==1 then
		return "REDY_USE"
    elseif prc_fuel >= .75 then
        return "SOON"
    elseif prc_fuel >= .5 then
        return "MEDIUM"
    else
        return "LONG"
    end
	
end

local function haunt_lf(inst, doer)
--self.haunted = self.onhaunt(self.inst, doer)
	local redy=false
	if inst.components.fueled.currentfuel == inst.components.fueled.maxfuel then
		redy=true
		inst.components.fueled:MakeEmpty()
	end
	return redy
end

local function fn()
    local inst = CreateEntity()
	
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

	inst.AnimState:SetBank("llorar_flower")
    inst.AnimState:SetBuild("llorar_flower")
    inst.AnimState:PlayAnimation("idle_1")

    MakeInventoryPhysics(inst)

    inst.MiniMapEntity:SetIcon("llorar_flower.tex")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE
	inst.components.fueled:InitializeFuelLevel(TUNING.LARGE_FUEL * 5)--TUNING.MINERHAT_LIGHTTIME)
	--inst.components.fueled:SetDepletedFn(lf_DepletedFn)--miner_perish)
	--inst.components.fueled.ontakefuelfn = lf_takefuel--miner_takefuel
	inst.components.fueled.accepting = true
	inst.components.fueled:SetSections(5)
	inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "llorar_flower"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/llorar_flower.xml"	
	--inst.components.inventoryitem:SetOnDroppedFn(ondropped)
    --inst.components.inventoryitem:SetOnPickupFn(onpickup)
	
	inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = getstatus

	--[[inst.OnLoad = onload
    inst.OnSave = onsave
    inst.OnRemoveEntity = unlink
    inst.Refresh = refresh]]
	
	inst:AddTag("resurrector")

	inst:AddComponent("hauntable")
	inst.components.hauntable:SetHauntValue(TUNING.HAUNT_INSTANT_REZ)
	inst.components.hauntable:SetOnHauntFn(haunt_lf)
    
    return inst
end

return Prefab("common/inventory/llorar_flower", fn, assets, prefabs)