require "libs.copy-utils"

local shrinker = deepcopy(data.raw["inserter"]["fast-inserter"])
overwriteContent(shrinker, {
	name = "shrinker",
	order = "z[shrinker]",
	minable = {mining_time = 0.5, result = "shrinker"},
})
shrinker.hand_closed_picture.filename = "__Miniaturization__/graphics/entity/shrinker-hand-closed.png"
shrinker.hand_open_picture.filename = "__Miniaturization__/graphics/entity/shrinker-hand-open.png"
shrinker.hand_base_picture.filename = "__Miniaturization__/graphics/entity/shrinker-hand-base.png"
shrinker.platform_picture.sheet.filename = "__Miniaturization__/graphics/entity/shrinker-platform.png"
shrinker.icon = "__Miniaturization__/graphics/icons/shrinker.png"

local expander = deepcopy(data.raw["inserter"]["filter-inserter"])
overwriteContent(expander, {
	name = "expander",
	order = "z[expander]",
	minable = {mining_time = 0.5, result = "expander"},
})
expander.hand_closed_picture.filename = "__Miniaturization__/graphics/entity/expander-hand-closed.png"
expander.hand_open_picture.filename = "__Miniaturization__/graphics/entity/expander-hand-open.png"
expander.hand_base_picture.filename = "__Miniaturization__/graphics/entity/expander-hand-base.png"
expander.platform_picture.sheet.filename = "__Miniaturization__/graphics/entity/expander-platform.png"
expander.icon = "__Miniaturization__/graphics/icons/expander.png"

data:extend({	shrinker, expander })