extends Node3D
class_name EntityHero

@onready var _component_health = $ComponentHealth
@onready var _component_needs = $ComponentNeeds
@onready var _utility_decision = $UtilityDecision

signal update_ui(needs)

func _ready() -> void:
	ManagerGame.register_entity(self)
	_component_health.died.connect(_entity_died)


func _exit_tree() -> void:
	ManagerGame.unregister_entity(self)


func  _process(delta: float) -> void:
	update_ui.emit( _component_needs.need_values )


func update(delta : float) -> void:
	update_ui.emit( _component_needs.need_values )
	_component_needs.update_decay(delta)
	_utility_decision.context = _component_needs.need_values
	var action_to_do : UtilityAction = _utility_decision.get_best_action()
	
	var fulfiller : Node3D = ManagerBuildings.find_nearest_fulfiller(global_position, action_to_do.actionID)
	global_position = fulfiller.global_position
	_component_needs.need_values[action_to_do.actionID] += fulfiller.get_child(1)._fulfilled_needs[action_to_do.actionID]

func update_fast(delta: float) -> void:
	pass  # combat, animation, etc

func update_slow(delta: float) -> void:
	update(delta)


func _entity_died() -> void:
	queue_free()
