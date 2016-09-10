if not Miniaturization then Miniaturization = {} end
if not Miniaturization.config then Miniaturization.config = {} end

require("config")
function Initialize(event)
	global["Miniaturization_shrinkerlist"] = global["Miniaturization_shrinkerlist"] or {}
	global["Miniaturization_expanderlist"] = global["Miniaturization_expanderlist"] or {}
	global["Miniaturization_shrinker_state"] = global["Miniaturization_shrinker_state"] or {}
	global["Miniaturization_expander_state"] = global["Miniaturization_expander_state"] or {}
	global["Miniaturization_item_id"] = global["Miniaturization_item_id"] or {}
	global["Miniaturization_id_data"] = global["Miniaturization_id_data"] or {}
	global["Miniaturization_tech_level"] = 1
end

function UpdateTechLevel(event)
	if event.research.name == "miniaturization-research-2" then
		global["Miniaturization_tech_level"] = 2
	elseif event.research.name == "miniaturization-research-2" then
		global["Miniaturization_tech_level"] = Miniaturization.config.max_level
	end
end

function CreateItem(event)
	if event.created_entity.name == "shrinker" then
		local entity = event.created_entity
		global["Miniaturization_shrinkerlist"][entity.unit_number] = entity
		global["Miniaturization_shrinker_state"][entity.unit_number] = {stop = false}
	elseif event.created_entity.name == "expander" then
		local entity = event.created_entity
		global["Miniaturization_expanderlist"][entity.unit_number] = entity
		global["Miniaturization_expander_state"][entity.unit_number] = {stop = false}
		entity.set_filter(1, "compact-box")
	end
end

function id_to_health(id)
	return id / 65536.0
end

function health_to_id(health)
	return math.floor(health * 65536 + 0.5)
end

function PickUpItem(event)
	inv = game.players[event.player_index].get_inventory(defines.inventory.player_main)
	if event.entity.name == "shrinker" then
		for id, count in pairs(global["Miniaturization_shrinker_state"][event.entity.unit_number]) do
			if id ~= "stop" and count > 0 then
				local stack
				item_data = global["Miniaturization_id_data"][id]
				if item_data.level == 0 then
					stack = {name = item_data.item, count = count}
				else
					stack = {name = "compact-box", count = count, health = id_to_health(id)}
				end
				inv.insert(stack)
			end
		end
	end
end

function RunStep(event)
	for _, shrinker in pairs(global["Miniaturization_shrinkerlist"]) do
		if shrinker.valid then
			stack = shrinker.held_stack
			state = global["Miniaturization_shrinker_state"][shrinker.unit_number]
			if not stack.valid_for_read or stack.count == 0 then
				state.stop = false
			end
			if stack.valid_for_read and stack.count > 0 and state.stop == false then
				if stack.name ~= "compact-box" then
					if global["Miniaturization_item_id"][stack.name] == nil then
						n = #global["Miniaturization_id_data"] + 1
						global["Miniaturization_item_id"][stack.name] = n
						global["Miniaturization_id_data"][n] = {item = stack.name, level = 0}
					end
					stack.set_stack({name = "compact-box", count = stack.count, health = id_to_health(global["Miniaturization_item_id"][stack.name])})
				end
				id = health_to_id(stack.health)
				current_data = global["Miniaturization_id_data"][id]
				if current_data.level < Miniaturization.config.max_level and current_data.level < global["Miniaturization_tech_level"] then
					if state[id] == nil then
						state[id] = 0
					end
					state[id] = state[id] + stack.count
					quantity = math.floor(state[id] / Miniaturization.config.box_size)
					if quantity > 0 then
						state[id] = state[id] - quantity * Miniaturization.config.box_size
						if current_data.parent == nil then
							n = #global["Miniaturization_id_data"] + 1
							current_data.parent = n
							global["Miniaturization_id_data"][id] = current_data
							global["Miniaturization_id_data"][n] = {item = current_data.item, level = current_data.level + 1, child = id}
						end
						stack.set_stack({name = "compact-box", count = quantity, health = id_to_health(current_data.parent)})
						state.stop = true
					else
						stack.clear()
					end
				else
					state.stop = true
				end
			end
		else
			global["Miniaturization_shrinkerlist"][_] = nil
			global["Miniaturization_shrinker_state"][_] = nil
		end
	end
	
	for _, expander in pairs(global["Miniaturization_expanderlist"]) do
		if expander.valid then
			stack = expander.held_stack
			state = global["Miniaturization_expander_state"][expander.unit_number]
			if not stack.valid_for_read or stack.count == 0 then
				state.stop = false
			end
			if stack.valid_for_read and stack.count > 0 and state.stop == false and stack.name == "compact-box" then
				item_data = global["Miniaturization_id_data"][health_to_id(stack.health)]
				if item_data.level <= 1 then
					stack.set_stack({name = item_data.item, count = stack.count * Miniaturization.config.box_size})
				else
					stack.set_stack({name = "compact-box", count = stack.count * Miniaturization.config.box_size, health = id_to_health(item_data.child)})
				end
				state.stop = true
			end
		else
			global["Miniaturization_expanderlist"][_] = nil
			global["Miniaturization_expander_state"][_] = nil
		end
	end
end

script.on_init(Initialize)
script.on_event(defines.events.on_research_finished, UpdateTechLevel)
script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity}, CreateItem)
script.on_event({defines.events.on_preplayer_mined_item, defines.events.on_robot_pre_mined}, PickUpItem)
script.on_event(defines.events.on_tick, RunStep)