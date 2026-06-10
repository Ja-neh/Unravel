extends Node
class_name ComponentNeedFulfiller

@export var _fulfilled_needs : Dictionary = {}

func _ready() -> void:
	var building : Node3D = get_parent()
	ManagerBuildings.register_building(building , _fulfilled_needs.keys())

func _exit_tree() -> void:
	var building : Node3D = get_parent()
	ManagerBuildings.unregister_building(building, _fulfilled_needs.keys())
