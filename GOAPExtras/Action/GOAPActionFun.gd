extends GOAPAction
class_name GOAPActionFun

var saved_fulfiller

func _init(entity : Node3D) -> void:
	action_name = "fun"
	identifier = "fun"
	_pre_conditions = {}
	_effects = {"fun" : 100}
	_entity = entity


func execute(state : Dictionary) -> Dictionary:
	#saving fulfiller and its cost
	var fulfillers : Array = ManagerBuildings.get_three_closest_fulfillers_for_need(_entity.global_position, identifier)
	
	if fulfillers.is_empty():
		return {}
		
	var best_cost = INF
		
	for fulfiller in fulfillers:
		var fulfiller_cost = _evaluate_fulfiller(fulfiller)
		if fulfiller_cost < best_cost:
			saved_fulfiller = fulfiller
			best_cost = fulfiller_cost
	
	_cost = best_cost
	add_effects(saved_fulfiller)
	
	#execute
	var new_state = state.duplicate()
	
	for effect in _effects:
		var change = _effects[effect]
		var current = new_state[effect]
		
		#Booleans
		if typeof(change) == TYPE_BOOL:
			new_state[effect] = change
			
		#numbers
		else:
			var new_value = current + change
			new_state[effect] = clamp(new_value, _MIN_VALUE, _MAX_VALUE)
			
	return new_state


func _evaluate_fulfiller(fulfiller: Node3D) -> float:
	var gain = fulfiller.get_need_gain_amount(identifier)
	var distance = _entity.global_position.distance_to(fulfiller.global_position)
	var state = _entity.get_blackboard()
	var current = state.get(identifier)
	var deficit = 100 - current
	var effective_gain = min(gain, deficit)
	effective_gain = max(effective_gain, 1.0)
	
	var fulfiller_cost = (distance / effective_gain) + _cost
	
	return fulfiller_cost


func execute_real() -> bool:
	if saved_fulfiller:
		var _entity_nav_agent : NavigationAgent3D = _entity.nav_agent
		_entity_nav_agent.target_position = saved_fulfiller.global_position
		_entity.has_target = true
		
		if saved_fulfiller.in_area(_entity):
			saved_fulfiller.request_access(_entity, identifier)
			return true
			
	return false


func add_effects(fulfiller : Node3D) -> void:
	var value = fulfiller.get_need_gain_amount(identifier)
	_effects[identifier] = value
