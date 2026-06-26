extends GOAPGoal
class_name GOAPGoalSleep

func _init() -> void:
	goal_name = "sleep"
	identifier = "rest"
	target = 75
	operator = Operator.GreaterThan
