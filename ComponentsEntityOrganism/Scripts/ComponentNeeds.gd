extends Node
class_name ComponentNeeds

const _NEED_MIN_VALUE : int = 0
const _NEED_MAX_VALUE : int = 100

const _NEEDS = {
	"HUNGER": "hunger",
	"REST": "rest",
	"FUN": "fun",
	"SOCIAL": "social"
}

var need_values: Dictionary[String, int] = {
	"hunger": 100,
	"rest": 100,
	"fun": 100,
	"social": 100
}

@export var hunger_decay_rate: float = 0.01
@export var rest_decay_rate: float = 0.003
@export var fun_decay_rate: float = 0.015
@export var social_decay_rate: float = 0.008


func update_decay(delta: float) -> void:
	_modify_need("hunger", -hunger_decay_rate * delta)
	_modify_need("rest", -rest_decay_rate * delta)
	_modify_need("fun", -fun_decay_rate * delta)
	_modify_need("social", -social_decay_rate * delta)


func modify_need(need: String, amount: float) -> void:
	_modify_need(need, amount)


func _modify_need(need : String , amount : float) -> void:
	var new_need_value : int = clamp(need_values[need] + amount, _NEED_MIN_VALUE , _NEED_MAX_VALUE)
	need_values[need] = new_need_value
