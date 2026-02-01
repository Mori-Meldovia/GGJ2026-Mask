extends Node2D


var items: Array[Node]
var box
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if box == null:
		box = get_tree().get_first_node_in_group("Box")
	items = get_tree().get_nodes_in_group("Item")
	
	if items.size() <= 0 and box != null and box.current_capacity == 0:
		$MenuUI._on_level_complete()
