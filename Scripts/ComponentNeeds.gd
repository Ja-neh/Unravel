extends Node
class_name ComponentNeeds

const NEEDS = {
	"HUNGER": "hunger",
	"REST": "rest",
	"FUN": "fun",
	"SOCIAL": "social"
}

var need_values: Dictionary = {
	"hunger": 100,
	"rest": 100,
	"fun": 100,
	"social": 100
}

func _modify_need(need : String , amount : int):
	var new_need_value : int = clamp(need_values[need] + amount, -100 , 100)
	need_values[need] = new_need_value
