extends Node3D
class_name EntityHero

@onready var _component_health = $ComponentHealth
@onready var _component_primary_needs = $ComponentPrimaryNeeds
@onready var _component_secondary_needs = $ComponentSecondaryNeeds
@onready var _utility_decision_primary : UtilityDecision = $UtilityDecisionPrimary
@onready var _utility_decision_secondary: UtilityDecision = $UtilityDecisionSecondary


signal update_ui(needs)
var current_need_action : String
var completing_action : bool = false

func _ready() -> void:
	ManagerGame.register_entity(self)


func _exit_tree() -> void:
	ManagerGame.unregister_entity(self)


func  _process(delta: float) -> void:
	var needs : Dictionary = _component_primary_needs.get_component_state().duplicate()
	var other_needs = _component_secondary_needs.get_component_state().duplicate()
	for need in other_needs:
		needs[need] = other_needs[need]
	update_ui.emit( needs )


func update_decision(delta : float) -> void:
	if not completing_action:
		#primary needs
		var p_needs : Dictionary = _component_primary_needs.get_component_state().duplicate()
		for need in p_needs:
			if p_needs[need] < 45:
				_utility_decision_primary.set_context(p_needs) 
				var action_to_do : UtilityAction = _utility_decision_primary.get_best_action()
				current_need_action = action_to_do.get_identifier()
				
				var fulfiller : Node3D = ManagerBuildings.find_nearest_fulfiller(global_position, current_need_action)
				if fulfiller:
					global_position = fulfiller.global_position
					fulfiller.request_access(self, need_action())
				return
				
		#seconadry needs
		var s_needs : Dictionary = _component_secondary_needs.get_component_state().duplicate()
		for need in s_needs:
			if s_needs[need] < 45:
				_utility_decision_secondary.set_context(s_needs) 
				var action_to_do : UtilityAction = _utility_decision_secondary.get_best_action()
				current_need_action = action_to_do.get_identifier()
		
				var fulfiller : Node3D = ManagerBuildings.find_nearest_fulfiller(global_position, current_need_action)
				if fulfiller:
					global_position = fulfiller.global_position
					fulfiller.request_access(self, need_action())
				return


func update_need(need : String, amount : float) -> void:
	if _component_primary_needs.has_need(need):
		_component_primary_needs.modify_need(need, amount)
	else:
		_component_secondary_needs.modify_need(need, amount)


func update_fast(delta: float) -> void:
	update_decision(delta)


func update_slow(delta: float) -> void:
	_component_primary_needs.update_decay()
	_component_secondary_needs.update_decay()


func need_action() -> String:
	return current_need_action
