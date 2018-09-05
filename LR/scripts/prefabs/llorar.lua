local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}

local prefabs = {
    "llorar_flower",
}

local start_inv = {
    "llorar_flower",
}

-- This initializes for both clients and the host
local common_postinit = function(inst)
    -- Minimap icon
    inst.MiniMapEntity:SetIcon("llorar.tex")

end

local function onhealthchange_llorar(inst)

    --local delta = 1
    local cur_health = 1
    cur_health = inst.components.health:GetPercent()
    if cur_health == 1 then
        --при полном здоровье
        inst.components.combat.damagemultiplier = .75 --множитель урона = 0.75
    elseif cur_health >= .5 then
        --при неполном здоровье выше или равной половине
        inst.components.combat.damagemultiplier = 2 - cur_health --множитель урона = 2-(от .99 до .5) = от 1.01 до 1.5
    elseif cur_health < .5 then
        --при неполном здоровье меньше половины
        inst.components.combat.damagemultiplier = 3 - cur_health --множитель урона = 3-(от 0.5 до 0) = от 2.5 до 3
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

local function onseasonchange_llorar(inst, season)
    local base_hurtrate = inst.components.health.maxhealth / TUNING.FREEZING_KILL_TIME -- 0.9 (wilson = 1.25)
    if season == SEASONS.WINTER then
        inst.components.temperature.maxtemp = (25)
        inst.components.temperature.hurtrate = base_hurtrate * 3
    else
        inst.components.temperature.maxtemp = (90)
        inst.components.temperature.hurtrate = base_hurtrate
    end
end

-- This initializes for the host only
local master_postinit = function(inst)
    -- choose which sounds this character will play
    inst.soundsname = "wisp"

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

    inst:AddTag("ghostlyfriend")
    inst:AddTag("llorar_flower_owner")

    TUNING.MY_POSITIVE_INSULATOR = 50
    TUNING.MY_NEGATIVE_INSULATOR = 10 -- should always be less than 30
    inst.components.temperature.inherentinsulation = -20
    local OldGetInsulation = inst.components.temperature.GetInsulation
    inst.components.temperature.GetInsulation = function(self)
        local a, b = OldGetInsulation(self)
        return a - TUNING.MY_NEGATIVE_INSULATOR, b + TUNING.MY_POSITIVE_INSULATOR
    end
    onseasonchange_llorar(inst, TheWorld.state.season)
    inst:WatchWorldState("season", onseasonchange_llorar)

    inst:ListenForEvent("healthdelta", onhealthchange_llorar)

    --inst.llorar_flowers = {}

end

return MakePlayerCharacter("llorar", prefabs, assets, common_postinit, master_postinit, start_inv)
