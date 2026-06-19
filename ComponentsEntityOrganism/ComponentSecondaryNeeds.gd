extends ComponentNeeds
class_name ComponentSecondaryNeeds


const _NEEDS = {
	"MONEY" : "money",
	"SOCIAL" : "social",
	"FUN" : "fun"
}


func _ready() -> void:
	_need_values = {
		"money" : 100,
		"social" : 100,
		"fun" : 100
	}
