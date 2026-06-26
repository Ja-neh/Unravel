extends GOAPGoal
class_name GOAPGoalEat

func _init() -> void:
	goal_name = "eat"
	identifier = "hunger"
	target = 75
	operator = Operator.GreaterThan
