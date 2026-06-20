extends Node
class_name GOAPAction

const _MAX_VALUE = 100
const _MIN_VALUE = 0

@export var action_name : String
@export var _pre_conditions : Dictionary
@export var _effects : Dictionary
@export var _cost : float = 1


func get_effects() -> Dictionary:
	return _effects


func get_pre_conditions() -> Dictionary:
	return _pre_conditions


func get_cost() -> float:
	return calculate_cost()


func are_pre_conditions_met(state : Dictionary) -> bool:
	for condition in _pre_conditions:
		if _pre_conditions[condition] != state[condition]:
			return false
			
	return true


func execute(state : Dictionary) -> Dictionary:
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


func calculate_cost() -> float:
	print("WARNING: GOAP Action calculate_cost called from base class")
	return 0
