extends Node3D

#region variables
@onready var component_need_fulfiller = $ComponentNeedFulfiller
@onready var area = $Area3D

var _fulfilled_needs : Array[String] = []
var _entities_in_building : Dictionary[Node3D , int] = {}
const TIME_LEFT_COUNTDOWN_BY : int = 1

@export var building_name : String
#endregion

func _ready() -> void:
	_fulfilled_needs = component_need_fulfiller.needs_fulfilled()
	ManagerBuildings.register_building(self, _fulfilled_needs)
	
	area.body_entered.connect(_entity_entered)
	area.body_exited.connect(_entity_exited)


func _exit_tree() -> void:
	ManagerBuildings.unregister_building(self, _fulfilled_needs)


#region entities interaction
func _entity_entered(body : Node3D):
	if body is CharacterBody3D:
		var need : String = body.need_action()
		if not _entities_in_building.has(body):
			var time = component_need_fulfiller.time_to_complete_need(need)
			_entities_in_building[body] = time
			body.completing_action = true


func _entity_exited(body : Node3D):
	if _entities_in_building.has(body):
		_entities_in_building.erase(body)
#endregion


func world_tick(delta : float) -> void:
	_update(delta)
	
	
func _update(delta : float) -> void:
	for entity in _entities_in_building:
		_entities_in_building[entity] -= TIME_LEFT_COUNTDOWN_BY
		
		if _entities_in_building[entity] == 0:
			var need = entity.need_action()
			var amount = component_need_fulfiller.need_gain(need)
			entity.update_need(need , amount)
			entity.completing_action = false
			
			
