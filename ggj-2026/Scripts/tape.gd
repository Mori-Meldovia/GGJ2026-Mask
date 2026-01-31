extends Sprite2D

var dragging = true
var scaling = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_local_mouse_position() + Vector2(0, 1)
	look_at(get_global_mouse_position())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		look_at(get_global_mouse_position())
	#scale and rotate sprite so it follows mouse
	#when click is released, stop following mouse
	
	if Input.is_action_just_released("Click"):
		dragging = false
		
	if scaling and dragging:
		scale += Vector2(4, 0)
	
	if get_rect().has_point(get_local_mouse_position()):
		scaling = false
	else:
		scaling = true





#func _on_area_2d_mouse_entered() -> void:
	#scaling = false
#
#
#func _on_area_2d_mouse_exited() -> void:
	#scaling = true
