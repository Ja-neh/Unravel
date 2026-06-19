extends Node
class_name ComponentNeedFulfiller

#need, need_gain
@export var _fulfilled_needs : Dictionary[String, int]
#need, time(no. of ticks to complete)
@export var _times_to_complete : Dictionary[String, int]


func get_needs_fulfilled() -> Array[String]:
	return _fulfilled_needs.keys()


func get_need_gain(need : String) -> int:
	return _fulfilled_needs[need]


func get_time_to_complete_need(need : String) -> int:
	return _times_to_complete[need]
