extends Area3D

signal update_world_on_npcs

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var demon: CharacterBody3D
	var heroes : Array
	if has_overlapping_bodies():
		var bodies = get_overlapping_bodies()
		for body in bodies:
			if body is Demon:
				demon = body
			elif body is Hero:
				heroes.push_back(body)
				
		update_world_on_npcs.emit(demon, heroes)
