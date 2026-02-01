extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var player_model: PlayerModel 

@export var max_safety_time: float = 15.0
@export var warning_time: float = 5.0

var kill_timer: float = 0.0 #The kill timer kills the player if it reaches zero.

var is_player_safe: bool = false
var killed_player: bool = false

signal player_died

var player: CharacterBody3D

@export var follow_height: float = 5.0
@export var follow_speed: float = 3.0

func _ready() -> void:
	player_model = get_tree().get_first_node_in_group("player").get_node("Model")
	player_model.safety_changed.connect(_on_player_safety_changed)
	kill_timer = max_safety_time 
	
	player = get_tree().get_first_node_in_group("player")

	
	
func _process(delta: float) -> void:
	#print("Are you safe?", is_player_safe)
	print(animation_player.current_animation)
	
	if killed_player == true:
		return
	
	if not is_player_safe:
		kill_timer -= delta
		if kill_timer <= 0.0:
			kill_player()
		if kill_timer < warning_time:
			animation_player.play("danger-coming")
		if !animation_player.is_playing():
			animation_player.play("oscillating-shadow")
			
	follow_player(delta)
	
func follow_player(delta):
	var target_position = player.global_position + Vector3.UP * follow_height
	global_position = global_position.lerp(target_position, follow_speed * delta)

	
	
func _on_player_safety_changed(is_safe: bool):
	is_player_safe = is_safe
	if is_safe:
		if animation_player.is_playing() and (animation_player.current_animation == "oscillating-shadow" or animation_player.current_animation == "danger-coming") :
			animation_player.play("flying-away")
		kill_timer = max_safety_time
	if not is_safe:
		animation_player.play("flying-in")
		
	#print("Vulture sees you are ", is_player_safe)
	

func kill_player():
	print("emitting dead signal")
	player_died.emit()
	killed_player = true
	
	
	#print("player died at position: " , player.global_position)
	# Spawn some animation at the death position if needed 
	
