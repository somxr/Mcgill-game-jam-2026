extends Node
class_name PlayerModel

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var player: CharacterBody3D = $".."
@onready var visual: Node3D = $"../visual"
@onready var ground_ray_cast_3d: RayCast3D = $"../visual/GroundRayCast3D"


@onready var vulture = get_tree().get_first_node_in_group("vulture")


var current_state : State

@onready var states = {
	"idle": $Idle,
	#"skate": $Skate,
	#"jump": $Jump,
	"walk": $Walk,
	"dying": $Dying
}


var is_safe: bool = false
signal safety_changed(is_safe: bool)
var is_dead: bool = false


func _ready():
	current_state = states["idle"]
	for state in states:
		states[state].player = player
		states[state].visual = visual
		
	if vulture:
		vulture.player_died.connect(_on_player_died)


func update(input: InputPackage, delta: float):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		
	var next_state = current_state.check_transition(input)
	if next_state != "unchanged":
		switch_state(next_state)
	current_state.update(input, delta)
	
	#rotate_on_slopes()
	#print(current_state)
	#print("safety status ", is_safe)
	
	manage_safety_status(delta)

func switch_state(next_state: String):
	current_state.exit_state()
	current_state = states[next_state]
	current_state.enter_state()
	
func manage_safety_status(delta: float):
	pass

func set_is_safe(new_safety: bool):
	if new_safety != is_safe:
		is_safe = new_safety
		safety_changed.emit(is_safe)
	
	
func _on_player_died():
	print("Player recieved dying signal")
	switch_state("dying")
	
func rotate_on_slopes():
	var ground_normal: Vector3 = ground_ray_cast_3d.get_collision_normal()
	var forward_dir: Vector3 = -visual.basis.z
	
	if ground_normal == Vector3.ZERO:
		ground_normal = Vector3.UP
	
	visual.basis = Basis.looking_at(-forward_dir, ground_normal)

	
###########################################################
#func velocity_by_input(input: InputPackage, delta: float) -> Vector3:
	#var new_velocity = player.velocity
	#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#new_velocity.x = direction.x * SPEED
		#new_velocity.z = direction.z * SPEED
	#else:
		#new_velocity.x = move_toward(new_velocity.x, 0, SPEED)
		#new_velocity.z = move_toward(new_velocity.z, 0, SPEED)
	#
		## Handle jump.
	#if input.is_jumping and player.is_on_floor():
		#new_velocity.y += JUMP_VELOCITY
#
	#if not player.is_on_floor():
		#new_velocity.y -= gravity * delta
	#
	#return new_velocity
