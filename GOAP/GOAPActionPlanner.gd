class_name GOAPActionPlanner

# Node in the A* search tree
class PlanNode:
	var state: Dictionary
	var action: GOAPAction
	var parent: PlanNode
	var cost: float = 0.0
	var depth: int = 0
	
	func _init(_state: Dictionary, _action: GOAPAction, _parent: PlanNode, _cost: float, _depth: int):
		state = _state
		action = _action
		parent = _parent
		cost = _cost
		depth = _depth
		
	func get_actions() -> Array[GOAPAction]:
		var actions: Array[GOAPAction] = []
		var current: PlanNode = self
		while current.parent != null:
			actions.append(current.action)
			current = current.parent
		actions.reverse()
		return actions


func get_plan(goal: GOAPGoal, state: Dictionary, actions: Array[GOAPAction]) -> Array[GOAPAction]:
	if goal.is_goal_satisfied(state):
		return []
	
	# A* search
	var open_set: Array[PlanNode] = []
	var closed_set: Dictionary = {}  # state_hash -> true
	
	# Start node
	var start_node = PlanNode.new(state, null, null, 0.0, 0)
	open_set.append(start_node)
	
	while not open_set.is_empty():
		open_set.sort_custom(_sort_by_cost)
		var current: PlanNode = open_set.pop_front()
		
		if goal.is_goal_satisfied(current.state):
			return current.get_actions()
		
		var state_hash = _hash_state(current.state)
		if closed_set.has(state_hash):
			continue
		closed_set[state_hash] = true
		
		
		for action in actions:
			if not _can_apply_action(action, current.state):
				continue
			
			# Apply the action to get new state
			var new_state = action.execute(current.state)
			
			# Calculate cost (action cost + parent cost)
			var action_cost = action.get_cost()
			var total_cost = current.cost + action_cost
			
			# Create child node
			var child = PlanNode.new(
				new_state,
				action,
				current,
				total_cost,
				current.depth + 1
			)
			
			if child.depth > 20:
				continue
			
			open_set.append(child)
	
	return []


func _can_apply_action(action: GOAPAction, state: Dictionary) -> bool:
	return action.are_pre_conditions_met(state)


func _sort_by_cost(a: PlanNode, b: PlanNode) -> bool:
	return a.cost < b.cost


func _hash_state(state: Dictionary) -> String:
	var keys = state.keys()
	keys.sort()
	var str = ""
	for key in keys:
		str += "%s:%s|" % [key, str(state.get(key))]
	return str
