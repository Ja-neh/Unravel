class_name Hero
extends "res://Scripts/Individual.gd"

var in_demon_realm = false
var level_up_progess = 0
var reach_to_level = 5

func _init() -> void:
	super()
	health = 100
	level = 0
	
	stats.attack = randf_range(10, 20)
	stats.defense = randf_range(10, 15)
	
	traits.cowardly = randf_range(0, 100)
	traits.curious = randf_range(0, 100)
	traits.lazy = randf_range(0, 100)
	
func _process(delta: float) -> void:
	if health < 0:
		health = 0
		queue_free()
		return
	
	if level_up_progess >= reach_to_level:
		level_up_progess = 0
		level += 1
		stats.attack *= (1 + (level / 5))

func decide() -> void:
	if not in_demon_realm:
		if health <= 95:
			health += 5
			
		if health >= 70:
			if attack():
				position = Vector3(randf_range(-7, 7), 2, randf_range(1, 15))
			
	else:
		if health < 15:
			var chance = randf_range(0, 10)
			if traits.cowardly < 20 and chance > 8:
				position = Vector3(randf_range(-7, 7), 2, randf_range(-15, -1))
				
			elif traits.cowardly > 70:
				position = Vector3(randf_range(-7, 7), 2, randf_range(-15, -1))
				
			elif chance > 5:
				position = Vector3(randf_range(-7, 7), 2, randf_range(-15, -1))
				
			else:
				return


func attack() -> bool:
	if traits.cowardly > 70.0 :
		var chance = randi_range(0, 4)
		if(chance == 1):
			return true
		return false
		
	if traits.curious > 80.0 :
		var chance = randi_range(0, 4)
		if(chance > 1):
			return true
		return false
		
	if traits.lazy > 90.0 :
		var chance = randi_range(0, 10)
		if(chance == 1):
			return true
		return false
		
	var chance = randi_range(0, 10)
	if chance > 3:
		return true
		
	return false
