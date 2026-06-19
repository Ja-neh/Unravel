extends Node
class_name ComponentNeeds

#region variables
const _NEED_MIN_VALUE : int = 0
const _NEED_MAX_VALUE : int = 100

#need, need_value
var _need_values : Dictionary[String, float]
#need, decay_rate
@export var _decay_rates : Dictionary[String, float]
#endregion variables


func _ready() -> void:
	print("WARNING : _ready called from base class for ComponentNeeds")


func update_decay() -> void:
	for need in _need_values:
		var amount = - _decay_rates[need]
		_modify_need(need, amount)


func modify_need(need: String, amount: float) -> void:
	_modify_need(need, amount)


func _modify_need(need : String , amount : float) -> void:
	var new_need_value : float = clamp(_need_values[need] + amount, _NEED_MIN_VALUE , _NEED_MAX_VALUE)
	_need_values[need] = new_need_value


func has_need(need: String) -> bool:
	return _need_values.has(need)


func get_need(need: String) -> float:
	return _need_values[need]


func get_component_state() -> Dictionary[String, float]:
	return _need_values
