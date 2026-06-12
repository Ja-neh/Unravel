extends UtilityConsideration
class_name UtilityConsiderationBoolean


func calculate_factor_score() -> float:
	return calculate_consideration_score()


func calculate_consideration_score() -> float:
	return int(utilityDecision.context[contextID])
