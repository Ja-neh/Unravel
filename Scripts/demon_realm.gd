extends Area3D


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
				
		if demon != null:
			demon.heroes_in_realm = heroes


func _on_body_entered(body: Node3D) -> void:
	if body is Hero:
		body.in_demon_realm = true


func _on_body_exited(body: Node3D) -> void:
	if body is Hero:
		body.in_demon_realm = false
		
		
