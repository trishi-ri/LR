local assets = {
    Asset("ANIM", "anim/llorar.zip"),
    Asset("ANIM", "anim/ghost_llorar_build.zip"),
}

local skins = {
    normal_skin = "llorar",
    ghost_skin = "ghost_llorar_build",
}

local base_prefab = "llorar"

local tags = { "LLORAR", "CHARACTER" }

return CreatePrefabSkin("llorar_none",
        {
            base_prefab = base_prefab,
            skins = skins,
            assets = assets,
            tags = tags,

            skip_item_gen = true,
            skip_giftable_gen = true,
        })