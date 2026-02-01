extends CharacterBody2D


@export var max_capacity = 20
@export var current_capacity = 0
@export var box_minigame_reference = "res://Scenes/box_wrap_minigame.tscn"
var full = false
var ready_to_go = false
var loaded = false
var launching = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if launching == true:
		move_and_slide()
	#if full == true and Input.is_action_just_pressed("Click"):
		#var scene = load(box_minigame_reference) # change this to be the minigame scene
		#var item = scene.instantiate()
		#add_child(item)

# if full, spawn a new scene that's the packing minigame
# slow down time elsewhere and have the minigame happen so that the player can't move other objects whilst doing this

func _on_area_2d_body_entered(body: Node2D) -> void:
	if full == false and body.is_in_group("Item"):
		current_capacity += body.get_volume()
		body.queue_free()
		print(current_capacity)
		if current_capacity >= max_capacity:
			full = true
			change_sprite("res://Assets/Cardboard Box Sprite Full.png")

func change_sprite(reference: String) -> void:
	var texture = load(reference)
	$Sprite2D.texture = texture


func _on_button_button_down() -> void:
	if full == true and loaded == false:
		var scene = load(box_minigame_reference) # change this to be the minigame scene
		var item = scene.instantiate()
		add_child(item)
		loaded = true

func complete() -> void:
	change_sprite("res://Assets/Cardboard Box Sprite Ready.png")
	ready_to_go = true

	
func launch() -> void:
	launching = true
	velocity = Vector2.UP * 500
	await get_tree().create_timer(1).timeout
	queue_free()
	
func get_ready():
	return ready_to_go

func set_box_position(pos: Vector2):
	global_position = pos
