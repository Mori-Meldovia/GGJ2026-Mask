extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("Spawn"):
		spawn_item()
		
func spawn_item() -> void:
	var scene = load("res://item.tscn")
	var item = scene.instantiate()
	add_child(item)
