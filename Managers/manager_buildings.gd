extends Node

var _buildings_by_needs : Dictionary = {}

func register_building(building : Node3D, needs : Array[String]) -> void:
	for need in needs:
		if not _buildings_by_needs.has(need):
			_buildings_by_needs[need] = []
		
		if building not in _buildings_by_needs[need]:
			_buildings_by_needs[need].append(building)
			
func unregister_building(building: Node3D, needs : Array[String]) -> void:
	for need in needs:
		if _buildings_by_needs[need].has(building):
			_buildings_by_needs[need].erase(building)
		if _buildings_by_needs[need].is_empty():
			_buildings_by_needs.erase(need)
			
func find_nearest_fulfiller(entity_position : Vector3, need : String) -> Node3D:
	var closest_fulfiller : Node3D
	var shortest_distance : float = INF

	var current_distance : float
	for fulfiller in _buildings_by_needs[need]:
		current_distance = entity_position.distance_squared_to(fulfiller.global_position)
		if current_distance < shortest_distance:
			shortest_distance = current_distance
			closest_fulfiller = fulfiller
			
	return closest_fulfiller
		
		
