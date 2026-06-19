extends Node
class_name ComponentHealth

var _min_health : float = 0
@export var _max_health : int
var _current_health : int


func _ready() -> void:
	_current_health = _max_health


func update_health(amount : float) -> void:
	var new_health : float = clamp(_current_health + amount , _min_health, _max_health)
	_current_health = new_health


func get_component_state() -> Dictionary[String, float]:
	return {"health" : _current_health}
