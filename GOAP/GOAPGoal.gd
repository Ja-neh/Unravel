extends Node
class_name GOAPGoal

var goal_name : String
#need tied to goal
var identifier : String
#float OR bool -- treshold OR condition
var target

enum Operator{
	LessThan, 
	GreaterThan, 
	EqualTo
}
var operator : Operator


func is_goal_satisfied(state : Dictionary):
	var new_value = state[identifier]
	match operator:
		Operator.LessThan : return new_value < target
		Operator.GreaterThan : return new_value > target
		Operator.EqualTo : return new_value == target
		
