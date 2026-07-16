extends Node
class_name GOAPAgent

var _current_goal: GOAPGoal = null
var _current_plan: Array[GOAPAction] = []
var _current_plan_step: int = 0
var _action_planner: GOAPActionPlanner = GOAPActionPlanner.new()
var _actions: Array[GOAPAction] = []
var _entity: Node3D


func _ready() -> void:
	_entity = get_parent()
	_actions = _entity.get_actions()


func set_actions(actions: Array[GOAPAction]) -> void:
	_actions = actions


func update_agent_on_goal(goal: GOAPGoal, blackboard: Dictionary) -> void:
	if goal == null:
		return
	
	# If goal changed, re-plan
	if _current_goal == null or _goal_changed(goal):
		_current_goal = goal
		_current_plan = _action_planner.get_plan(goal, blackboard, _actions)
		_current_plan_step = 0
		#_is_executing = false
	
	# Follow the plan
	_follow_plan()


func _goal_changed(new_goal: GOAPGoal) -> bool:
	return _current_goal.goal_name != new_goal.goal_name


func _follow_plan() -> void:
	# If no plan, stop
	if _current_plan.is_empty():
		_current_plan_step = 0
		return
	
	# Check if plan is complete
	if _current_plan_step >= _current_plan.size():
		_current_plan = []
		_current_plan_step = 0
		return
	
	# Execute the next action
	var action = _current_plan[_current_plan_step]
	_execute_action(action)


func _execute_action(action: GOAPAction) -> void:
	
	# Get current state from entity
	var state = _entity.get_blackboard() if _entity.has_method("get_blackboard") else {}
	
	# Check if preconditions are still met
	if not action.are_pre_conditions_met(state):
		# Re-plan immediately
		_current_plan = []
		_current_plan = _action_planner.get_plan(_current_goal, state, _actions)
		_current_plan_step = 0 
		return
	
	# Execute the action
	if action.execute_real():
		# Mark as complete (building will set completing_action = false)
		_current_plan_step += 1


func is_planning_complete() -> bool:
	return _current_plan.is_empty() or _current_plan_step >= _current_plan.size()
