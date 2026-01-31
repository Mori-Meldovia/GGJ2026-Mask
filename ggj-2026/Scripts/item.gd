extends RigidBody2D


var volume = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	position = Vector2(0, 400)

func get_volume() -> int:
	return volume
