extends UtilityConsideration
class_name UtilityConsiderationStat


func calculate_factor_score() -> float:
	return _calculate_consideration_score()


func _calculate_consideration_score() -> float:
	var utility : float = curve.sample( utilityDecision.get_need_from_context(need) )
	return utility
