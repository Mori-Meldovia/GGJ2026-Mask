extends Node2D

@onready var held: bool = false;
@onready var velocity: Vector2 = Vector2(0, 0)

@export var max_velocity: float = 10;
@export var weight: float = 10;


func _draw() -> void:
	if (Input.is_action_pressed("Click")):
		draw_circle(to_local(get_viewport().get_mouse_position()),  GlobalDaniel.circle_size, Color.RED);
	
func _physics_process(_delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position()
	queue_redraw()
	if (position.x < 0):
		position.x = 0
		velocity.x = 0
	if (position.y < 0):
		position.y = 0
		velocity.y = 0
	if (position.x > get_viewport().get_visible_rect().size.x):
		position.x = get_viewport().get_visible_rect().size.x - 1
		velocity.x = 0
	if (position.y > get_viewport().get_visible_rect().size.y):
		position.y = get_viewport().get_visible_rect().size.y - 1
		velocity.y = 0
			
	if held == true:
		#moves the thig directly to the thing
		#if distance between mouse and held object and mouse is
		#greater than radius (circle_size) pull towards object depending on distance
		
		#if (position.distance_to(mouse_position) > GlobalDaniel.circle_size):
		var pull_vector = Vector2(cos(get_angle_to(mouse_position)), sin(get_angle_to(mouse_position)))
		velocity += pull_vector
		
			
		
	if Input.is_action_just_released("Click"):
		held = false
		velocity 
	position += velocity


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		held = true;
