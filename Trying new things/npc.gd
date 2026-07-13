extends CharacterBody3D
class_name NPC

@onready var _component_health = $ComponentHealth
@onready var _component_primary_needs = $ComponentPrimaryNeeds
@onready var _component_secondary_needs = $ComponentSecondaryNeeds
@onready var _utility_decision_primary : UtilityDecision = $UtilityDecisionPrimary
@onready var _utility_decision_secondary: UtilityDecision = $UtilityDecisionSecondary
@export var _goap_agent: GOAPAgent

var current_need : String
var completing_action : bool = false

@onready var nav_agent : NavigationAgent3D #add nav_agent
var has_target : bool = false

func _ready() -> void:
	ManagerGame.register_entity(self)


func _physics_process(delta):
	if has_target:
		var next_path_pos = nav_agent.get_next_path_position()
		var dir = global_position.direction_to(next_path_pos)
		velocity = dir * 3.0
		
		if nav_agent.is_navigation_finished():
			has_target = false
			velocity = Vector3.ZERO


func get_actions() -> Array[GOAPAction]:
	return [
		GOAPActionEat.new(self),
		GOAPActionSleep.new(self),
		GOAPActionSocial.new(self),
		GOAPActionFun.new(self),
		GOAPActionWork.new(self)
	]


func get_blackboard() -> Dictionary:
	var blackboard : Dictionary
	
	var primary_needs = _component_primary_needs.get_component_state().duplicate()
	var secondary_needs = _component_secondary_needs.get_component_state().duplicate()
	
	for need in primary_needs:
		blackboard[need] = primary_needs[need]
		
	for need in secondary_needs:
		blackboard[need] = secondary_needs[need]
		
	blackboard["position"] = global_position
		
	return blackboard


func _exit_tree() -> void:
	ManagerGame.unregister_entity(self)


func update_need(need : String, amount : float) -> void:
	if _component_primary_needs.has_need(need):
		_component_primary_needs.modify_need(need, amount)
	else:
		_component_secondary_needs.modify_need(need, amount)


func update_slow(delta: float) -> void:
	_component_primary_needs.update_decay()
	_component_secondary_needs.update_decay()
	update_decision(delta)
	
	var pn : Dictionary = _component_primary_needs.get_component_state()
	var sn : Dictionary = _component_secondary_needs.get_component_state()
	
	for need in pn:
		print("%s : %f" % [need, pn[need]])

	for need in sn:
		print("%s : %f" % [need, sn[need]])
		
	print("############################################################################")


func update_fast(delta: float) -> void:
	pass


func update_decision(delta : float) -> void:
	if not completing_action:
		#primary needs
		var p_needs : Dictionary = _component_primary_needs.get_component_state().duplicate()
		for need in p_needs:
			if p_needs[need] < 45:
				_utility_decision_primary.set_context(p_needs) 
				var action_to_do : UtilityAction = _utility_decision_primary.get_best_action()
				current_need = action_to_do.get_identifier()
				var goal : GOAPGoal = NeedToGoal.match_need_to_goal(current_need)
				_goap_agent.update_agent_on_goal(goal, get_blackboard())
				return
				
		#seconadry needs
		var s_needs : Dictionary = _component_secondary_needs.get_component_state().duplicate()
		for need in s_needs:
			if s_needs[need] < 45:
				_utility_decision_secondary.set_context(s_needs) 
				var action_to_do : UtilityAction = _utility_decision_secondary.get_best_action()
				current_need = action_to_do.get_identifier()
				var goal : GOAPGoal = NeedToGoal.match_need_to_goal(current_need)
				_goap_agent.update_agent_on_goal(goal, get_blackboard())
				return

func need_action() -> String:
	return current_need
