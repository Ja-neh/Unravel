extends Node

#region variables
const WORLD_TICK_RATE: float = 1.0 / 60.0 # 60 times in a second
const SLOW_TICK_RATE: float = 3.0  # once every 3 second

var _accumulator: float = 0.0
var _slow_accumulator: float = 0.0

var _living_entities: Array[Node3D] = []
#endregion

#region registration
func register_entity(living_entity: Node3D) -> void:
	if living_entity not in _living_entities:
		_living_entities.append(living_entity)


func unregister_entity(living_entity : Node3D) -> void:
	_living_entities.erase(living_entity)
#endregion

func _process(delta: float) -> void:
	_accumulator += delta
	while _accumulator >= WORLD_TICK_RATE:
		_world_tick()
		_accumulator -= WORLD_TICK_RATE

	_slow_accumulator += delta
	while _slow_accumulator >= SLOW_TICK_RATE:
		_slow_tick()
		_slow_accumulator -= SLOW_TICK_RATE

#region ticks
func _world_tick() -> void:
	for entity in _living_entities:
		entity.update_fast(WORLD_TICK_RATE)
		
	

func _slow_tick() -> void:
	ManagerBuildings.world_tick(SLOW_TICK_RATE)
	
	for entity in _living_entities:
		entity.update_slow(SLOW_TICK_RATE)
#endregion
