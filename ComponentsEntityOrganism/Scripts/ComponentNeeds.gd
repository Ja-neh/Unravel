extends Node
class_name ComponentNeeds

const _NEED_MIN_VALUE : int = 0
const _NEED_MAX_VALUE : int = 100

const _NEEDS = {
	"HUNGER": "hunger",
	"REST": "rest",
	"SOCIAL": "social",
	"FUN": "fun"
}

var _need_values: Dictionary[String, float] = {
	"hunger": 100,
	"rest": 100,
	"social": 100,
	"fun": 100
}

@export var hunger_decay_rate: float = 2
@export var rest_decay_rate: float = 0.5
@export var social_decay_rate: float = 2.5
@export var fun_decay_rate: float = 1.2


func update_decay(delta: float) -> void:
	_modify_need("hunger", -hunger_decay_rate)
	_modify_need("rest", -rest_decay_rate)
	_modify_need("social", -social_decay_rate)
	_modify_need("fun", -fun_decay_rate)

func modify_need(need: String, amount: float) -> void:
	_modify_need(need, amount)


func _modify_need(need : String , amount : float) -> void:
	var new_need_value : float = clamp(_need_values[need] + amount, _NEED_MIN_VALUE , _NEED_MAX_VALUE)
	_need_values[need] = new_need_value


func get_need(need: String) -> float:
	return _need_values[need]


func get_all_needs() -> Dictionary[String, float]:
	return _need_values
