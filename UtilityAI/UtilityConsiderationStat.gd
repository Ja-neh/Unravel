extends UtilityConsideration
class_name UtilityConsiderationStat


func calculate_factor_score() -> float:
	return calculate_consideration_score()


func calculate_consideration_score() -> float:
	var utility : float = curve.sample( utilityDecision.context[contextID] )
	return utility
