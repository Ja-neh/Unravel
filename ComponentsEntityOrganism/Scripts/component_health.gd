extends Node
class_name ComponentHealth

signal died

@export var _max_health : int
var _current_health : int

func _ready() -> void:
	_current_health = _max_health

func take_damage(damage : int) -> void:
	_current_health -= damage
	if _current_health < 0:
		_current_health = 0
		died.emit()
		
func increase_health(amount : int) -> void:
	_current_health += amount
	if _current_health > _max_health:
		_current_health = _max_health
