extends Node3D
class_name EntityHero

@onready var _component_health = $ComponentHealth
@onready var _component_needs = $ComponentNeeds
@onready var _utility_decision = $UtilityDecision

signal update_ui(needs)
var current_need_action : String
var completing_action : bool = false

func _ready() -> void:
	ManagerGame.register_entity(self)
	_component_health.died.connect(_entity_died)


func _exit_tree() -> void:
	ManagerGame.unregister_entity(self)


func  _process(delta: float) -> void:
	update_ui.emit( _component_needs.get_all_needs() )


func update_decision(delta : float) -> void:
	if not completing_action:
		_utility_decision.context = _component_needs.get_all_needs()
		var action_to_do : UtilityAction = _utility_decision.get_best_action()
		current_need_action = action_to_do.actionID
		
		var fulfiller : Node3D = ManagerBuildings.find_nearest_fulfiller(global_position, action_to_do.actionID)
		if fulfiller:
			global_position = fulfiller.global_position


func update_need(need : String, amount : float) -> void:
	_component_needs.modify_need(need, amount)


func update_fast(delta: float) -> void:
	update_decision(delta)


func update_slow(delta: float) -> void:
	_component_needs.update_decay(delta)


func need_action() -> String:
	return current_need_action


func _entity_died() -> void:
	queue_free()
