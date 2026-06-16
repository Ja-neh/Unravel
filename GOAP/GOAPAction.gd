extends Resource
class_name GOAPAction

const _MAX_VALUE = 100
const _MIN_VALUE = 0

@export var identifier : String
@export var target_tag : String
@export var pre_conditions : Dictionary
@export var effects : Dictionary
@export var cost : float = 1

func are_pre_conditions_met(state : Dictionary) -> bool:
	for condition in pre_conditions:
		if pre_conditions[condition] != state[condition]:
			return false
			
	return true


func perform(state : Dictionary) -> Dictionary:
	var new_state = state.duplicate()
	
	for effect in effects:
		var change = effects[effect]
		var current = new_state[effect]
		
		#Booleans
		if typeof(change) == TYPE_BOOL:
			new_state[effect] = change
			
		#numbers
		else:
			var new_value = current + change
			new_state[effect] = clamp(new_value, _MIN_VALUE, _MAX_VALUE)
			
	return new_state


func calculate_cost(position : Vector3) -> float:
	print("WARNING: GOAP Action calculate_cost called from base class")
	return 0
