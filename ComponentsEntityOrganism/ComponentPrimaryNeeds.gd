extends ComponentNeeds
class_name ComponentPrimaryNeeds


const _NEEDS = {
	"HUNGER": "hunger",
	"REST": "rest"
}


func _ready() -> void:
	_need_values = {
		"hunger": 100,
		"rest": 100
	}
