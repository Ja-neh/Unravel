extends UtilityFactor
class_name UtilityConsideration

@export var need : String
@export var curve : Curve

func calculate_factor_score() -> float:
	return _calculate_consideration_score()


func _calculate_consideration_score() -> float:
	print("WARNING: calculate_consideration_score called from base class. Needs to be overridden")
	return 0
