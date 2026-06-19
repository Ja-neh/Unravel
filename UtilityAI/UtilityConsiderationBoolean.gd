extends UtilityConsideration
class_name UtilityConsiderationBoolean


func calculate_factor_score() -> float:
	return _calculate_consideration_score()


func _calculate_consideration_score() -> float:
	return int(utilityDecision.get_need_from_context(need))
