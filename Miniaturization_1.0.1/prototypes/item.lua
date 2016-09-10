require "libs.copy-utils"

local shrinker = deepcopy(data.raw["item"]["fast-inserter"])
overwriteContent(shrinker, {
	name = "shrinker",
	place_result = "shrinker",
	icon = "__Miniaturization__/graphics/icons/shrinker.png",
})

local expander = deepcopy(data.raw["item"]["filter-inserter"])
overwriteContent(expander, {
	name = "expander",
	place_result = "expander",
	icon = "__Miniaturization__/graphics/icons/expander.png",
})

data:extend({	shrinker, expander })

data:extend({
{
	type = "item",
	name = "compact-box",
	icon = "__Miniaturization__/graphics/icons/compact-box.png",
	flags = {"goes-to-main-inventory"},
	subgroup = "storage",
	order = "d[items]-b[steel-chest]",
	stack_size = 20
},
})