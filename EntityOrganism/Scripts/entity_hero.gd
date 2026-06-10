extends Node3D
class_name EntityHero

@onready var _component_health = $ComponentHealth
@onready var _component_needs = $ComponentNeeds

func _ready():
	_component_health.died.connect(_entity_died)
	
func _entity_died():
	queue_free()
	
