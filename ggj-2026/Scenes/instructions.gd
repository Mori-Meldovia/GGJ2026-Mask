extends Sprite2D



var isShown = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_button_button_down() -> void:
	isShown = !isShown
	$Button/Sprite2D.visible = isShown
