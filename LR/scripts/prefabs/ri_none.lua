local assets = {
    Asset("ANIM", "anim/ri.zip"),
    Asset("ANIM", "anim/ghost_ri_build.zip"),
}

local skins = {
    normal_skin = "ri",
    ghost_skin = "ghost_ri_build",
}

local base_prefab = "ri"

local tags = { "RI", "CHARACTER" }

return CreatePrefabSkin("ri_none",
        {
            base_prefab = base_prefab,
            skins = skins,
            assets = assets,
            tags = tags,

            skip_item_gen = true,
            skip_giftable_gen = true,
        })