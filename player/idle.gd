extends State
class_name Idle
@onready var ground_ray_cast_3d: RayCast3D = $"../../visual/GroundRayCast3D"
@onready var animation_player: AnimationPlayer = $"../../visual/turtlev3/AnimationPlayer"

@export var braking_speed = 5.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func check_transition(input: InputPackage) -> String:
	input.actions.sort_custom(states_priority_sort)
	return input.actions[0]
	
func update(input: InputPackage, delta: float):
	#if not player.is_on_floor():
		#player.velocity.y -= gravity * delta
	pass
	
func enter_state():
	player.velocity.x = move_toward(player.velocity.x, 0, braking_speed)
	player.velocity.z = move_toward(player.velocity.z, 0, braking_speed)
	animation_player.pause()

func exit_state():
	pass
