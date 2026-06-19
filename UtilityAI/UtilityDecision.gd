extends Node
class_name UtilityDecision

enum CalculationMethod{
	ADD,
	SUBTRACT,
	MULTIPLY,
	DIVIDE,
	AVERAGE,
	MIN,
	MAX
}

@export var actions : Array[UtilityAction]
var _context : Dictionary = {}


func _ready() -> void:
	for action in actions:
		action.utilityDecision = self
		
		for factor in action.factors:
			factor.utilityDecision = self


func set_context(context : Dictionary) -> void:

	_context = context


func get_need_from_context(need : String) -> float:
	return _context[need]


#action in name... but could also be viwed as need to fulfill
func get_best_action() -> UtilityAction:
	var bestAction : UtilityAction = actions[0]
	var highestScore : float = 0
	
	for action in actions:
		var actionScore : float = action.calculate_utility_score()
		
		if actionScore > highestScore:
			highestScore = actionScore
			bestAction = action
			
	return bestAction


func calculate_final_score(calculationMethod : CalculationMethod, scores : Array[float]) -> float:
	match calculationMethod:
		CalculationMethod.ADD:
			return calculate_via_add(scores)
		CalculationMethod.SUBTRACT:
			return calculate_via_subtraction(scores)
		CalculationMethod.MULTIPLY:
			return calculate_via_multiply(scores)
		CalculationMethod.DIVIDE:
			return calculate_via_division(scores)
		CalculationMethod.AVERAGE:
			return calculate_via_average(scores)
		CalculationMethod.MIN:
			return calculate_via_min(scores)
		CalculationMethod.MAX:
			return calculate_via_max(scores)
		_:
			print("CALCULATION METHOD INVALID OR NOT SET UP")
			return 0


#region calculation methods implementations
func calculate_via_add(scores : Array[float]) -> float:
	var totalScore : float = scores[0]
	
	for i in range(1, scores.size()):
		totalScore += scores[i]
	
	return totalScore


func calculate_via_subtraction(scores : Array[float]) -> float:
	var totalScore : float = scores[0]
	
	for i in range(1, scores.size()):
		totalScore -= scores[i]
	
	return totalScore


func calculate_via_multiply(scores : Array[float]) -> float:
	var totalScore : float = scores[0]
	
	for i in range(1, scores.size()):
		totalScore *= scores[i]
	
	return totalScore


func calculate_via_division(scores : Array[float]) -> float:
	var totalScore : float = scores[0]
	
	for i in range(1, scores.size()):
		totalScore /= scores[i]
	
	return totalScore


func calculate_via_average(scores : Array[float]) -> float:
	var totalScore : float = scores[0]
	
	for i in range(1, scores.size()):
		totalScore += scores[i]
	
	totalScore /= (scores.size() - 1)
	
	return totalScore


func calculate_via_min(scores : Array[float]) -> float:
	return scores.min()


func calculate_via_max(scores : Array[float]) -> float:
	return scores.max()
#endregion
