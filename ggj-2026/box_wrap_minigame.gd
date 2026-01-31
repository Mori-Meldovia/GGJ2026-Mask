extends StaticBody2D


var box_owner
var taping = false
var tape_num = 3
@export var tape_minigame_reference = "res://tape.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(0, -110)
	box_owner = get_tree().get_first_node_in_group("Box")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Death"):
		queue_free()
	if tape_num <= 0:
		box_owner.complete()
		queue_free()



func _on_button_button_down() -> void:
	var scene = load(tape_minigame_reference) # change this to be the minigame scene
	var item = scene.instantiate()
	add_child(item)
	


func _on_button_button_up() -> void:
	tape_num -= 1
	print(tape_num)
