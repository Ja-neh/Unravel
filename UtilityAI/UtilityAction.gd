extends Node
class_name UtilityAction

@export var actionID : String
@export var calculationMethod : UtilityDecision.CalculationMethod
@export var factors : Array[UtilityFactor]

var scores : Array[float]
var utilityDecision : UtilityDecision


func calculate_utility_score() -> float:
	scores.clear()
	
	for factor in factors:
		scores.append( factor.calculate_factor_score() )
		
	return utilityDecision.calculate_final_score(calculationMethod, scores)
