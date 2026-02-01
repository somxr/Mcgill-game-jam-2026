extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node3D):
	if body.is_in_group("player"):
		print("Player won")
		body.get_node("Model").set_is_safe(true)


func _on_body_exited(body: Node3D):
	if body.is_in_group("player"):
		print("Player shouldnt be able to leave win area ")
