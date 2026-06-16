extends GOAPGoal
class_name SatisfyHunger

func _init() -> void:
	identifier = "hunger"
	treshold = 70
	operator = Operator.GreaterThan
