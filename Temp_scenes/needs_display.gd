extends Control

@onready var hunger = $BoxContainer/Hunger
@onready var rest = $BoxContainer/Rest
@onready var social = $BoxContainer/Social
@onready var fun = $BoxContainer/Fun


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		var hero = get_node("/root/World/EntityHero") 
		if hero:
			hero.update_ui.connect(_update)
		else:
			print("No hero found – make sure EntityHero is in group 'hero'")


func _update(needs : Dictionary):
	hunger.text = "Hunger : " + str(needs.get("hunger", 0))
	rest.text = "Rest : " + str(needs.get("rest", 0))
	social.text = "Social : " + str(needs.get("social", 0))
	fun.text = "Fun : " + str(needs.get("fun", 0))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
