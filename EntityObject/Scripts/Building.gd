extends Node3D

#region variables
@onready var _component_need_fulfiller = $ComponentNeedFulfiller
@onready var _area = $Area3D

var _fulfilled_needs : Array[String]
#entity, time_left(no. of ticks left to complete)
var _entities_in_building : Dictionary[Node3D , int] = {}
#ticks left countdown rate
const TIME_LEFT_COUNTDOWN_BY : int = 1

@export var building_name : String
#endregion


func _ready() -> void:
	_fulfilled_needs = _component_need_fulfiller.get_needs_fulfilled()
	ManagerBuildings.register_fulfiller(self, _fulfilled_needs)


func _exit_tree() -> void:
	ManagerBuildings.unregister_fulfiller(self, _fulfilled_needs)


#region entities interaction
func request_access(entity : Node3D) -> void:
	if entity in _area.get_overlapping_bodies():
		if not _entities_in_building.has(entity):
			var need = entity.need_action()
			var time = _component_need_fulfiller.get_time_to_complete_need(need)
			_entities_in_building[entity] = time
			entity.completing_action = true
#endregion


func world_tick(delta : float) -> void:
	_update(delta)


func _update(delta : float) -> void:
	var to_remove: Array[Node3D] = []

	for entity in _entities_in_building:
		_entities_in_building[entity] -= TIME_LEFT_COUNTDOWN_BY
		if _entities_in_building[entity] <= 0:
			var need = entity.need_action()
			var amount = _component_need_fulfiller.get_need_gain(need)
			entity.update_need(need, amount)
			entity.completing_action = false
			to_remove.append(entity)

	for entity in to_remove:
		_entities_in_building.erase(entity)
