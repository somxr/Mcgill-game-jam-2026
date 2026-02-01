extends State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func _ready():
	#animation = "dasdasd"
	#move_name = "dasdasdas"
	pass

# Step 5: implement a check_relevance function to manage transitions, return action name or "unchanged"
func check_transition(input : InputPackage):
	return "unchanged"

func update(input : InputPackage, delta : float):
	player.velocity = Vector3.ZERO
	if not animated_sprite_2d.is_playing():
		animated_sprite_2d.visible = false
		visual.visible = false
		

func enter_state():
	player.velocity = Vector3.ZERO
	animated_sprite_2d.visible = true
	animated_sprite_2d.play("default")
	

func exit_state():
	pass
