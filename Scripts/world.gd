extends Node3D

signal hero_count_update

var heroes : Array
var demon : CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_node_3d_2_advance_world() -> void:	
	for hero in heroes:
		hero.decide()
		
	var demon_alive : int
	if demon != null:
		demon.fight()
		demon_alive = 1
	else:
		demon_alive = 0
		
	hero_count_update.emit( heroes.size(), demon_alive)
	
	print("AFTER UPDATE")
	if demon != null:
		print(demon)
		print("health : %s" % demon.health)
	for hero in heroes:
		print(hero)
		print("health : %s ; level : %s" % [hero.health, hero.level])
		print("attack : %s ; defence : %s" % [hero.stats.attack, hero.stats.defense])
		print("cowardly : %s ; lazy : %s ; curious : %s" % [hero.traits.cowardly, hero.traits.lazy, hero.traits.curious])
	print("")
	print("#########################################################################################")
		
func _on_world_update_world_on_npcs(tdemon, theroes) -> void:
	demon = tdemon
	heroes = theroes
