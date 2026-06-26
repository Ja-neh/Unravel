extends GOAPGoal
class_name GOAPGoalWork

func _init() -> void:
	goal_name = "work"
	identifier = "money"
	target = 75
	operator = Operator.GreaterThan
