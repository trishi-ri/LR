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
        Asset( "ANIM", "anim/llorar.zip" ),
        Asset( "ANIM", "anim/ghost_llorar_build.zip" ),
		--Asset( "ANIM", "anim/llorar_flower.zip"),
}

local prefabs =
{
    "llorar_flower",
}

local start_inv = {
	"llorar_flower",
}

-- This initializes for both clients and the host
local common_postinit = function(inst) 
	-- choose which sounds this character will play
	inst.soundsname = "wisp"

	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "llorar.tex" )
	
	inst:AddTag("ghostlyfriend")
	inst:AddTag("llorar_flower_owner")
	
end

local function onhealthchange(inst)
 
	--local delta = 1
	local cur_health = 1
	cur_health = inst.components.health:GetPercent()
	if cur_health == 1 then --при полном здоровье
		inst.components.combat.damagemultiplier = .75 --множитель урона = 0.75
	elseif cur_health >= .5 then --при неполном здоровье выше или равной половине
		inst.components.combat.damagemultiplier = 2-cur_health --множитель урона = 2-(от .99 до .5) = от 1.01 до 1.5
	elseif cur_health < .5 then --при неполном здоровье меньше половины
		inst.components.combat.damagemultiplier = 3-cur_health --множитель урона = 3-(от 0.5 до 0) = от 2.5 до 3
	end
	--print (string.format("damagemultiplier: %2.2f", inst.components.combat.damagemultiplier))
    
	--[[
	100 1 2-1=1
	50 .5 2-.5=1.5
	10 .1 2-.1=2.9
	1  .01 2-.01 = 2.99]]
	
	--[[if cur_health <= .5 then
		delta = 2
	elseif cur_health < .4 then
		delta = 3
	elseif cur_health < .3 then
		delta = 4
	elseif cur_health < .2 then
		delta = 5
	elseif cur_health < .1 then
		delta = 6
	end
	
	return delta]]
	
end

-- This initializes for the host only
local function master_postinit(inst)
	
	inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED) --скорость ходьбы = 4(как у Вилсона)
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED)  --скорость бега = 6(как у Вилсона)
	
	-- Stats	
	inst.components.health:SetMaxHealth(TUNING.WILSON_HEALTH * .75) --здоровье = 112.5 (3/4 от показателя Вилсона) 
	
	inst.components.hunger:SetMax(TUNING.WILSON_HUNGER) --сытость = 150 (как у Вилсона) 
	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * .75) --падение сытости = 0.15625*.75 = 0.1171875(3/4 от показателя Вилсона) 
	
	inst.components.sanity:SetMax(TUNING.WILSON_SANITY) --рассудок = 200 (как у Вилсона) 
	inst.components.sanity.night_drain_mult = .5 --рассудок night_drain_mult = 0.5 (1/2 от показателя Вилсона) 

	inst.components.sanity.neg_aura_mult = 0 --рассудок neg_aura_mult = 0 
	inst.components.sanity.ghost_drain_mult = 0 --рассудок ghost_drain_mult = 0 

	--inst.components.freezable:SetResistance(-5)
	
	if TheWorld.state.iswinter then	
		inst.components.temperature.maxtemp = ( 25 )
		inst.components.temperature.hurtrate = ( 2.5 )
	end
	
	inst:WatchWorldState("startwinter", function() -- Announce Winter starting, set max temp and damage rate
		if inst.components.talker then
			inst.components.talker:Say(GetString(inst, "ANNOUNCE_WINTER"))
			inst.components.temperature.maxtemp = ( 25 )
			inst.components.temperature.hurtrate = ( 2.5 )
		end
	end)

	inst:WatchWorldState("startspring", function() -- Announce Winter ending, set max temp and damage rate
		if inst.components.talker then
			inst.components.talker:Say(GetString(inst, "ANNOUNCE_SPRING"))
			inst.components.temperature.maxtemp = ( 90 )
			inst.components.temperature.hurtrate = ( 1.25 )
		end
	end)
	
	inst:WatchWorldState("startsummer", function() -- Set max temp and damage rate
		if inst.components.talker then
		inst.components.temperature.maxtemp = ( 90 )
		inst.components.temperature.hurtrate = ( 1.25 )
		end
	end)
	
	inst:WatchWorldState("startautumn", function() -- Set max temp and damage rate
		if inst.components.talker then
		inst.components.temperature.maxtemp = ( 90 )
		inst.components.temperature.hurtrate = ( 1.25 )
		end
	end)
	
	inst:ListenForEvent("healthdelta", onhealthchange)

	--inst.llorar_flowers = {}

end

return MakePlayerCharacter("llorar", prefabs, assets, common_postinit, master_postinit, start_inv)
