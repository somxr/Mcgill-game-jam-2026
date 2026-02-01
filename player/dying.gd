extends State


func _ready():
	#animation = "dasdasd"
	#move_name = "dasdasdas"
	pass

# Step 5: implement a check_relevance function to manage transitions, return action name or "unchanged"
func check_transition(input : InputPackage):
	return "unchanged"

func update(input : InputPackage, delta : float):
	player.velocity = Vector3.ZERO


func on_enter_state():
	print("entered die state")
	player.velocity = Vector3.ZERO

func on_exit_state():
	pass
