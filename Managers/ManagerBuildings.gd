extends Node

#region variables
#need, array of fulfillers
var _fulfillers_by_needs : Dictionary[String, Array] = {}
var _fulfillers : Array[Node3D] = []
#endregion

#region registration
func register_fulfiller(fulfiller : Node3D, needs : Array[String]) -> void:
	for need in needs:
		if not _fulfillers_by_needs.has(need):
			_fulfillers_by_needs[need] = []
		
		if fulfiller not in _fulfillers_by_needs[need]:
			_fulfillers_by_needs[need].append(fulfiller)
			
	if not _fulfillers.has(fulfiller):
		_fulfillers.append(fulfiller)

func unregister_fulfiller(fulfiller: Node3D, needs : Array[String]) -> void:
	for need in needs:
		if _fulfillers_by_needs[need].has(fulfiller):
			_fulfillers_by_needs[need].erase(fulfiller)
		if _fulfillers_by_needs[need].is_empty():
			_fulfillers_by_needs.erase(need)
	
	if _fulfillers.has(fulfiller):
		_fulfillers.erase(fulfiller)
#endregion


#region find fulfiller
func find_nearest_fulfiller(entity_position : Vector3, need : String) -> Node3D:
	var closest_fulfiller : Node3D
	var shortest_distance : float = INF

	var current_distance : float
	
	if _fulfillers_by_needs.has(need):
		for fulfiller in _fulfillers_by_needs[need]:
			current_distance = entity_position.distance_squared_to(fulfiller.global_position)
			if current_distance < shortest_distance:
				shortest_distance = current_distance
				closest_fulfiller = fulfiller
			
	return closest_fulfiller


func get_three_closest_fulfillers_for_need(entity_position : Vector3, need : String) -> Array[Node3D]:
	var return_fulfillers : Array[Node3D]
	var fulfillers_ordered : Array
	
	if not _fulfillers_by_needs.has(need):
		return []
	
	for fulfiller in _fulfillers_by_needs[need]:
		var current_distance = entity_position.distance_squared_to(fulfiller.global_position)
		fulfillers_ordered.append([current_distance, fulfiller])
	
	fulfillers_ordered.sort_custom(_sort_by_distance_to_fulfiller)
	
	var count = min(3, fulfillers_ordered.size())
	for i in range(count):
		return_fulfillers.append(fulfillers_ordered[i][1])
		
	return return_fulfillers


func _sort_by_distance_to_fulfiller(a , b) -> bool:
	return a[0] < b[0]
#endregion


#region world rick
func world_tick(delta : float) -> void:
	for fulfiller in _fulfillers:
		fulfiller.world_tick(delta)
#endregion
