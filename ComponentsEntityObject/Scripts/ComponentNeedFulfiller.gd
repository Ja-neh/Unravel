extends Node
class_name ComponentNeedFulfiller

@export var _fulfilled_needs : Dictionary[String, int] = {}
@export var _times_to_complete_needs : Dictionary[String, int] = {}


func needs_fulfilled() -> Array[String]:
	return _fulfilled_needs.keys()


func need_gain(need : String):
	return _fulfilled_needs[need]


func time_to_complete_need(need : String):
	return _times_to_complete_needs[need]
