extends Node
class_name GOAPAgent

var _current_goal : GOAPGoal
var _current_plan
var _current_plan_step : int = 0
var _action_planner : GOAPActionPlanner

var _entity : Node3D


func _init(entity : Node3D) -> void:
	_entity = entity


func update_agent_on_goal(goal : GOAPGoal, blackboard : Dictionary) -> void:
	var _goal = goal
	
	if _current_plan == null or _goal != _current_goal:
		_current_goal = _goal
		# _action_planner.get_plan(_current_goal , blackboard)
		
	else:
		_follow_plan(_current_plan)


func _follow_plan(plan):
	pass
	
