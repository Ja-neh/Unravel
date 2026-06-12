extends UtilityFactor
class_name UtilityConsideration

@export var contextID : String
@export var curve : Curve

func calculate_factor_score() -> float:
	return calculate_consideration_score()


func calculate_consideration_score() -> float:
	print("WARNING: calculate_consideration_score called from base class. Needs to be overridden")
	return 0
