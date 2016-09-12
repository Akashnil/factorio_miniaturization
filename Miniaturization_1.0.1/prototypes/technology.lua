data:extend({
{
    type = "technology",
    name = "miniaturization-research",
    icon = "__Miniaturization__/graphics/technology/miniaturization.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "shrinker"
      },
	  {
        type = "unlock-recipe",
        recipe = "expander"
      }
    },
    prerequisites = {"electronics", "logistics"},
    unit =
    {
      count = 50,
      ingredients = {{"science-pack-1", 1}},
      time = 15
    },
    order = "a-d-a",
},
{
    type = "technology",
    name = "miniaturization-research-2",
    icon = "__Miniaturization__/graphics/technology/miniaturization-2.png",
    effects = {},
    prerequisites = {"miniaturization-research", "advanced-electronics", "logistics-2"},
    unit =
    {
      count = 200,
      ingredients = {{"science-pack-1", 1}, {"science-pack-2", 1}},
      time = 15
    },
    order = "a-d-a",
},
{
    type = "technology",
    name = "miniaturization-research-3",
    icon = "__Miniaturization__/graphics/technology/miniaturization-3.png",
    effects = {},
    prerequisites = {"miniaturization-research-2", "logistics-3"},
    unit =
    {
      count = 500,
      ingredients = {{"science-pack-1", 1}, {"science-pack-2", 1}, {"science-pack-3", 1}, {"alien-science-pack", 1}},
      time = 15
    },
    order = "a-d-a",
},
})