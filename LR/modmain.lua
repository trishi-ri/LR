local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

PrefabFiles = {
	"llorar",
    "llorar_none",
	"llorar_flower",
	"ri",
	"ri_none",
}

Assets = {
	
	--Llorar
	Asset( "IMAGE", "images/saveslot_portraits/llorar.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/llorar.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/llorar.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/llorar.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/llorar_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/llorar_silho.xml" ),

	Asset( "IMAGE", "bigportraits/llorar.tex" ),
    Asset( "ATLAS", "bigportraits/llorar.xml" ),
	
	Asset( "IMAGE", "images/map_icons/llorar.tex" ),
	Asset( "ATLAS", "images/map_icons/llorar.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_llorar.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_llorar.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_llorar.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_llorar.xml" ),

    Asset( "IMAGE", "images/avatars/self_inspect_llorar.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_llorar.xml" ),

	--Asset("SOUNDPACKAGE", "sound/llorar.fev"),
    --Asset("SOUND", "sound/llorar.fsb"),
	Asset("SOUNDPACKAGE", "sound/wisp.fev"),
    Asset("SOUND", "sound/wisp.fsb"),
	
	--Ri
	Asset( "IMAGE", "images/saveslot_portraits/ri.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/ri.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/ri.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/ri.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/ri_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/ri_silho.xml" ),

	Asset( "IMAGE", "bigportraits/ri.tex" ),
    Asset( "ATLAS", "bigportraits/ri.xml" ),
	
	Asset( "IMAGE", "images/map_icons/ri.tex" ),
	Asset( "ATLAS", "images/map_icons/ri.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ri.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ri.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_ri.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_ri.xml" ),

    Asset( "IMAGE", "images/avatars/self_inspect_ri.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_ri.xml" ),
	
	-- other things
	Asset("IMAGE", "images/inventoryimages/llorar_flower.tex"),   
    Asset("ATLAS", "images/inventoryimages/llorar_flower.xml"),
	

}

--RemapSoundEvent("dontstarve/characters/llorar/death_voice", "llorar/characters/llorar/death_voice" )
--RemapSoundEvent("dontstarve/characters/llorar/hurt", "llorar/characters/llorar/hurt" )
--RemapSoundEvent("dontstarve/characters/llorar/talk_LP", "llorar/characters/llorar/talk_LP" )
RemapSoundEvent( "dontstarve/characters/wisp/death_voice", "wisp/wisp/death_voice" )
RemapSoundEvent( "dontstarve/characters/wisp/hurt", "wisp/wisp/hurt" )
RemapSoundEvent( "dontstarve/characters/wisp/talk_LP", "wisp/wisp/talk_LP" )

-----------------------------------------------
-- New Crafts!

	--local resolvefilepath = GLOBAL.resolvefilepath
	--local TECH = GLOBAL.TECH
	--local RECIPETABS = GLOBAL.RECIPETABS
	--local Recipe = GLOBAL.Recipe
	--local Ingredient = GLOBAL.Ingredient
	--local STRINGS = GLOBAL.STRINGS

	--AddRecipe("llorar_flower",
	--	{
	--		Ingredient("petals", 6),
	--		Ingredient("nightmarefuel", 4)
	--	},
	--	RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, 'llorar_flower_owner', "images/inventoryimages/llorar_flower.xml")
	STRINGS.NAMES.LLORAR_FLOWER = "Flower of Hope"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.LLORAR_FLOWER = "Flower of Hope"
	--STRINGS.RECIPE_DESC.LLORAR_FLOWER = "The last hope."

------------------------------------------------

-- The character select screen lines
STRINGS.CHARACTER_TITLES.llorar = "The Last Hope"
STRINGS.CHARACTER_NAMES.llorar = "Llorar"
STRINGS.CHARACTER_DESCRIPTIONS.llorar = "*He is dead. \n*He is a cat."
STRINGS.CHARACTER_QUOTES.llorar = "\"Mrrrow...\""

STRINGS.CHARACTER_TITLES.ri = "The red panda"
STRINGS.CHARACTER_NAMES.ri = "Ri"
STRINGS.CHARACTER_DESCRIPTIONS.ri = "*She is nocturnal and crepuscular. \n*She has night vision and hunger drain like Wei.  \n*She talks like Wendy."
STRINGS.CHARACTER_QUOTES.ri = "\"Wow!\""

-- The default responses of examining the character
--STRINGS.CHARACTERS.GENERIC.DESCRIBE.LLORAR =
--{
--	GENERIC = "It's Llorar.",
--	ATTACKER = "That Llorar looks shifty...",
--	MURDERER = "Murderer!",
--	REVIVER = "Llorar, friend of ghosts.",
--	GHOST = "Llorar could use a heart.",
--}
--
--STRINGS.CHARACTERS.GENERIC.DESCRIBE.RI =
--{
--	GENERIC = "It's Ri.",
--	ATTACKER = "That Ri looks shifty...",
--	MURDERER = "Murderer!",
--	REVIVER = "Ri, friend of ghosts.",
--	GHOST = "Ri could use a heart.",
--}

-- The character's name as appears in-game 
STRINGS.NAMES.LLORAR = "Llorar"
STRINGS.NAMES.RI = "Ri"

-- Custom speech strings
STRINGS.CHARACTERS.LLORAR = require "speech_llorar"
STRINGS.CHARACTERS.RI = require "speech_ri"

AddPrefabPostInit('llorar_flower')

-- Mapicon
AddMinimapAtlas("images/map_icons/llorar.xml")
AddMinimapAtlas("images/map_icons/ri.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("llorar", "MALE")
AddModCharacter("ri", "FEMALE")