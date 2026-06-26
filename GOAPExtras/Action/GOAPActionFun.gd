extends GOAPAction
class_name GOAPActionFun

func _init() -> void:
	action_name = "fun"
	identifier = "fun"
	_pre_conditions = {}
	_effects = {"fun" : 100}

func execute_real(entity : Node3D) -> void:
	var fulfiller : Node3D = ManagerBuildings.find_nearest_fulfiller(entity.global_position, identifier)
	if fulfiller:
		entity.global_position = fulfiller.global_position
		fulfiller.request_access.call_deferred(entity, identifier)

func calculate_cost() -> float:
	return 1
