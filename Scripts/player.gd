extends CharacterBody3D

signal advance_world

var human = preload("res://Scenes/human.tscn")
var hero = preload("res://Scenes/hero.tscn")
var demon = preload("res://Scenes/demon.tscn")
var heroes = 0
var demons = 0

const SPEED := 5.0
const JUMP_VELOCITY := 10.0

@export var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot
@onready var camera := $TwistPivot/PitchPivot/Camera3D

var normal_falling_multiplier := 2.0
var smash_falling_multiplier := 100.0
var is_smashing := false
var disable_smash_vector_y_factor := 0.25

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta: float) -> void:
	#Free mouse
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# Add the gravity.
	if not is_on_floor():
		if Input.is_action_just_pressed("smash_ground"):
			if (velocity.y > 0 && velocity.y < disable_smash_vector_y_factor * JUMP_VELOCITY) || (velocity.y < 0 && velocity.y > - disable_smash_vector_y_factor * JUMP_VELOCITY):
				velocity += get_gravity() * delta * smash_falling_multiplier
				is_smashing = true
		else:
			velocity += get_gravity() * delta * normal_falling_multiplier

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var forward = camera.global_basis.z
	var right = camera.global_basis.x
	var direction = forward * input_dir.y + right * input_dir.x
	direction.y = 0.0
	direction = direction.normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	#Camera movement2
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, -0.5, 0.5)
	twist_input = 0.0
	pitch_input = 0.0

	move_and_slide()
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spawn_hero"):
		if heroes < 5:
			spawn_hero()
			
	if Input.is_action_just_pressed("spawn_demon"):
		if demons < 1:
			spawn_demon()
			
	if Input.is_action_just_pressed("advance"):
		advance_world.emit()
	
	
func _unhandled_input(event: InputEvent) -> void:
	#Camera movement1
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
			
	#Lock mouse if it was free
	if event is InputEventMouseButton:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
			
			
			
func spawn_hero() -> void:
	heroes = heroes + 1
	var hero_instance = hero.instantiate()
	var mesh_instance = hero_instance.get_node("MeshInstance3D")
	var material = mesh_instance.get_surface_override_material(0)

	if material == null:
		material = StandardMaterial3D.new()
		mesh_instance.material_override = material
	material.albedo_color = Color( randf_range(0, 0.75), randf_range(0, 1), randf_range(0, 1) )
	
	hero_instance.position = Vector3( randf_range(-7, 7), 2, randf_range(-15, -1))
	get_tree().root.add_child(hero_instance)
	
	
func spawn_demon() -> void:
	demons = demons + 1
	var demon_instance = demon.instantiate()
	var mesh_instance = demon_instance.get_node("MeshInstance3D")
	var material = mesh_instance.get_surface_override_material(0)

	if material == null:
		material = StandardMaterial3D.new()
		mesh_instance.material_override = material
	material.albedo_color = Color( 1, 0, 0)
	
	demon_instance.position = Vector3( randf_range(-7, 7), 2, randf_range(15, 1))
	get_tree().root.add_child(demon_instance)


func _on_node_3d_hero_count_update(theroes, tdemon) -> void:
	heroes = theroes
	demons = tdemon
