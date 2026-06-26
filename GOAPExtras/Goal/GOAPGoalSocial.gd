extends GOAPGoal
class_name GOAPGoalSocial

func _init() -> void:
	goal_name = "social"
	identifier = "social"
	target = 75
	operator = Operator.GreaterThan
