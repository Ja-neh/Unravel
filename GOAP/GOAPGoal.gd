class_name GOAPGoal

var identifier : String
var effect_target : String
var treshold

enum Operator{
	LessThan, 
	GreaterThan, 
	EqualTo
}
var operator : Operator


func is_goal_satisfied(state : Dictionary):
	var new_value = state[identifier]
	match operator:
		Operator.LessThan : return new_value < treshold
		Operator.GreaterThan : return new_value > treshold
		Operator.EqualTo : return new_value == treshold
		
