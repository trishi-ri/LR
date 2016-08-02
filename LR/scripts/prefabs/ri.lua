local MakePlayerCharacter = require "prefabs/player_common"


local assets = { Asset( "ANIM", "anim/player_basic.zip" ),
        Asset( "ANIM", "anim/player_idles_shiver.zip" ),
        Asset( "ANIM", "anim/player_actions.zip" ),
        Asset( "ANIM", "anim/player_actions_axe.zip" ),
        Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
        Asset( "ANIM", "anim/player_actions_shovel.zip" ),
        Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
        Asset( "ANIM", "anim/player_actions_eat.zip" ),
        Asset( "ANIM", "anim/player_actions_item.zip" ),
        Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
        Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
        Asset( "ANIM", "anim/player_actions_fishing.zip" ),
        Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
        Asset( "ANIM", "anim/player_bush_hat.zip" ),
        Asset( "ANIM", "anim/player_attacks.zip" ),
        Asset( "ANIM", "anim/player_idles.zip" ),
        Asset( "ANIM", "anim/player_rebirth.zip" ),
        Asset( "ANIM", "anim/player_jump.zip" ),
        Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
        Asset( "ANIM", "anim/player_teleport.zip" ),
        Asset( "ANIM", "anim/wilson_fx.zip" ),
        Asset( "ANIM", "anim/player_one_man_band.zip" ),
        Asset( "ANIM", "anim/shadow_hands.zip" ),
        Asset( "SOUND", "sound/sfx.fsb" ),
        Asset( "SOUND", "sound/wilson.fsb" ),
        Asset( "ANIM", "anim/beard.zip" ),

        -- Don't forget to include your character's custom assets!
        Asset( "ANIM", "anim/ri.zip" ),
        Asset( "ANIM", "anim/ghost_ri_build.zip" ),
}

local prefabs = {}

local start_inv = 
{
	"bedroll_straw",
}

-- This initializes for both clients and the host
local common_postinit = function(inst) 
	-- choose which sounds this character will play
	inst.soundsname = "wendy"

	inst:AddTag("nocturn")
	
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "ri.tex" )
end

--[[local function updatespeed(inst, phase)
    
	if phase == "day" then
        inst.components.locomotor.runspeed = .6 * TUNING.WILSON_RUN_SPEED
	elseif phase == "dusk" then
		inst.components.locomotor.runspeed = 1.2 * TUNING.WILSON_RUN_SPEED		
    elseif phase == "night" then
		inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED
    end
	
end]]

local function sanityfn(inst)
 
	local delta = 0
	 
	if TheWorld.state.isday then
		delta = -0.25
	elseif TheWorld.state.isdusk then
		delta = 0.08
	elseif TheWorld.state.isnight then
		delta = 0.08
	end
	
	return delta
	
end

 --nightvision 
local function onsanitychange(inst, data)

	if inst.components.sanity.current > 40 then
		local light = inst.entity:AddLight()
		light:SetIntensity(.3)
		light:SetRadius(6)
		light:SetFalloff(1)
		light:Enable(true)
		light:SetColour(0/255, 150/255, 130/255)
		
	elseif inst.components.sanity.current < 40 then
		
		local light = inst.entity:AddLight()
		light:SetIntensity(.2)
		light:SetRadius(3)
		light:SetFalloff(0.7)
		light:Enable(true)
		light:SetColour(0/255,150/255, 130/255)
		
	elseif inst.components.sanity.current > 30 then
		local light = inst.entity:AddLight()
		light:SetIntensity(.1)
		light:SetRadius(1)
		light:SetFalloff(0.3)
		light:Enable(true)
		light:SetColour(0/255, 150/255, 130/255)
	
	elseif inst.components.sanity.current < 30 then
		local light = inst.entity:AddLight()
		light:SetIntensity(0)
		light:SetRadius(0)
		light:SetFalloff(0)
		light:Enable(false)
		light:SetColour(0/255, 0/255, 0/255)
		
	end
end
 
 --local tempCaveVar = false 

 -- Change movespeed at dusk and night
local function updatestats(inst)

	if TheWorld.state.phase == "day" then
	
		inst.Light:Enable(false)

		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * .6)
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * .6)
		
		inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED * -1)
		
		inst.components.combat.damagemultiplier = 1
	   
	elseif TheWorld.state.phase == "dusk" then

		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.2)
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.2)
		
		inst.components.sanity.dapperness = (TUNING.DAPPERNESS_LARGE)
		
		inst.components.combat.damagemultiplier = 2

	elseif TheWorld.state.phase == "night" then

		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1)
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1)
		
		inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED_LARGE)

		inst.components.combat.damagemultiplier = 2

  --[[  elseif tempCaveVar == true then
		
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.75)
		inst.components.locomotor.runspeed = (TUNING.WILSON_WALK_SPEED * 1.2)
		
		inst.components.sanity.dapperness = (TUNING.DAPPERNESS_SMALL * 6)
		
		inst.components.combat.damagemultiplier = 2
		]]
	end

end

-- This initializes for the host only
local function master_postinit(inst)
	
	inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED)
	
	-- Stats	
	inst.components.health:SetMaxHealth(100)
	inst.components.hunger:SetMax(100)
	inst.components.sanity:SetMax(100)
	
	inst.components.combat.min_attack_period = 0.5
	
	-- inst.components.temperature.inherentinsulation = TUNING.INSULATION_MED
	
	local light = inst.entity:AddLight()
	light:SetIntensity(0)
	light:SetRadius(0)
	light:SetFalloff(0)
	light:Enable(false)
	light:SetColour(0/255, 0/255, 0/255)	
	inst:ListenForEvent("sanitydelta", onsanitychange)
		
	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 2)
	
	inst.components.sanity.night_drain_mult = (TUNING.WENDY_SANITY_MULT * -2)
	--inst.components.sanity.custom_rate_fn = sanityfn
	
	inst:WatchWorldState("phase", updatestats)
    updatestats(inst)
	
end

return MakePlayerCharacter("ri", prefabs, assets, common_postinit, master_postinit, start_inv)
