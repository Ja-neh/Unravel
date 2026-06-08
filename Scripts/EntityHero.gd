extends Node
class_name EntityHero

@onready var component_health = $ComponentHealth
@onready var component_needs = $Component_needs

func _ready():
	component_health.died.connect(_entity_died)
	
func _entity_died():
	queue_free()
