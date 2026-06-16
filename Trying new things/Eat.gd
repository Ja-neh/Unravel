extends GOAPAction
class_name Eat

func _init() -> void:
	identifier = "hunger"
	pre_conditions = {"have_food" : true}
	effects = {}
