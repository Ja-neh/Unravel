extends Node

const TICK_RATE: float = 1.0 / 60.0
const SLOW_TICK_RATE: float = 1.0  # once per second

var _accumulator: float = 0.0
var _slow_accumulator: float = 0.0

var _living_entities: Array[Node3D] = []

func register_entity(living_entity: Node3D) -> void:
	if living_entity not in _living_entities:
		_living_entities.append(living_entity)


func unregister_entity(living_entity : Node3D) -> void:
	_living_entities.erase(living_entity)


func _process(delta: float) -> void:
	_accumulator += delta
	while _accumulator >= TICK_RATE:
		_fast_tick()
		_accumulator -= TICK_RATE

	_slow_accumulator += delta
	while _slow_accumulator >= SLOW_TICK_RATE:
		_slow_tick()
		_slow_accumulator -= SLOW_TICK_RATE

func _fast_tick() -> void:
	for entity in _living_entities:
		entity.update_fast(TICK_RATE)

func _slow_tick() -> void:
	for entity in _living_entities:
		entity.update_slow(SLOW_TICK_RATE)
		
		
