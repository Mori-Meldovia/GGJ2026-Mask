extends Sprite2D

var box
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	box = get_tree().get_first_node_in_group("Box")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if box == null:
		box = get_tree().get_first_node_in_group("Box")



func _on_button_button_down() -> void:
	if box.get_ready():
		box.launch()
		await get_tree().create_timer(2).timeout
		var scene = load("res://box.tscn")
		var item = scene.instantiate()
		add_child(item)
		box = item
