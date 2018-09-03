local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}

local prefabs = {}

-- Custom starting items
local start_inv = {
    "bedroll_straw",
}

-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst)
    -- choose which sounds this character will play
    inst.soundsname = "wendy"

    inst:AddTag("nocturn")

    -- Minimap icon
    inst.MiniMapEntity:SetIcon("ri.tex")
end

local function updatestats(inst)

    if (TheWorld.state.phase == "day" or TheWorld.state.phase == "caveday") then

        inst.Light:Enable(false)

        inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * .6)
        inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * .6)

        inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED * -1)

        inst.components.combat.damagemultiplier = 1

        inst.components.hunger.hungerrate = 0.5 * TUNING.WILSON_HUNGER_RATE

    elseif (TheWorld.state.phase == "dusk" or TheWorld.state.phase == "cavedusk") then

        inst.Light:Enable(true)

        inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 2)
        inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 2)

        inst.components.sanity.dapperness = (TUNING.DAPPERNESS_LARGE)

        inst.components.combat.damagemultiplier = 2

        inst.components.hunger.hungerrate = 2 * TUNING.WILSON_HUNGER_RATE

    elseif (TheWorld.state.phase == "night" or TheWorld.state.phase == "cavenight") then

        inst.Light:Enable(true)

        inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.2)
        inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.2)

        inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED_LARGE)

        inst.components.combat.damagemultiplier = 1

        inst.components.hunger.hungerrate = 1.5 * TUNING.WILSON_HUNGER_RATE

    end

end

--local function SleepTest(inst)
--    --not near home
--    --nocturnal sleeps in day
--    return StandardSleepChecks(inst)
--            and ((not TheWorld:HasTag("cave") and TheWorld.state.isday)
--            or (TheWorld:HasTag("cave") and TheWorld.state.iscaveday))
--
--end
--
--local function WakeTest(inst)
--    --nocturnal wakes once it's not day
--    --cavedwellers perceive "cavephase" instead of "phase"
--    return StandardWakeChecks(inst)
--            and ((not TheWorld:HasTag("cave") and not TheWorld.state.isday)
--            or (TheWorld:HasTag("cave") and not TheWorld.state.iscaveday))
--end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)

    inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED)

    -- Stats
    inst.components.health:SetMaxHealth(100)
    inst.components.hunger:SetMax(100)
    inst.components.sanity:SetMax(100)
    inst.Transform:SetScale(0.7, 0.7, 0.7)

    inst.components.combat.min_attack_period = 0.5

    -- inst.components.temperature.inherentinsulation = TUNING.INSULATION_MED

    local light = inst.entity:AddLight()
    light:SetIntensity(.3)
    light:SetRadius(6)
    light:SetFalloff(1)
    light:Enable(false)
    light:SetColour(0 / 255, 150 / 255, 130 / 255)

    --inst:ListenForEvent("sanitydelta", onsanitychange)
    --inst:AddComponent("playervision")
    --inst.components.playervision:ForceNightVision(true)

    -- Hunger rate (optional)
    --inst.components.hunger.hungerrate = 2 * TUNING.WILSON_HUNGER_RATE

    inst.components.sanity.night_drain_mult = (TUNING.WENDY_SANITY_MULT * -2)
    --inst.components.sanity.custom_rate_fn = sanityfn

    --inst:AddComponent("sleeper")
    --inst.components.sleeper:SetNocturnal(true)
    --inst.components.sleeper:SetSleepTest(SleepTest)
    --inst.components.sleeper:SetWakeTest(WakeTest)

    inst:WatchWorldState("phase", updatestats)
    updatestats(inst)

end

return MakePlayerCharacter("ri", prefabs, assets, common_postinit, master_postinit, start_inv)
