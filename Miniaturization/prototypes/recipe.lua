data:extend({
  {
    type = "recipe",
    name = "shrinker",
    enabled = false,
    ingredients =
    {
      {"filter-inserter", 2},
	  {"fast-inserter", 2},
      {"electronic-circuit", 5},
	  {"iron-gear-wheel", 32}
    },
    result = "shrinker",
    requester_paste_multiplier = 4,
	energy_required = 10,
  },
  {
    type = "recipe",
    name = "expander",
    enabled = false,
    ingredients =
    {
      {"filter-inserter", 2},
	  {"fast-inserter", 2},
      {"electronic-circuit", 2},
	  {"iron-gear-wheel", 32}
    },
    result = "expander",
    requester_paste_multiplier = 5,
	energy_required = 10,
  },
})