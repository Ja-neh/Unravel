class_name Demon
extends "res://Scripts/Individual.gd"

var heroes_in_realm : Array

func _init() -> void:
	super()
	health = 500
	
	stats.attack = 60.0
	stats.defense = 55.0

func _process(delta: float) -> void:
	if health < 0:
		health = 0
		queue_free()
		return

func fight() -> void:
	var num = heroes_in_realm.size()
	if num > 0:
		var attack_per_hero = stats.attack / num
		var defense_per_hero = stats.defense / num
		
		
		for hero in heroes_in_realm:
			var chance_to_block = randf_range(0.5, 1)
			var chance_to_get_hit = randf_range(0, 0.5)
			health = health - (hero.stats.attack * chance_to_get_hit) + (defense_per_hero * chance_to_block * 0.175)
			
			var chance_to_get_blocked = randf_range(0, 0.25)
			var chance_to_land_hit = randf_range(0.5, 1)
			hero.health = hero.health - (attack_per_hero * chance_to_land_hit) + (hero.stats.defense * chance_to_get_blocked * 0.25)
			if hero.health > 100:
				hero.health = 100
				
			hero.level_up_progess += 1
			
