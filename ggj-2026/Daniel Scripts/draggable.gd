extends RigidBody2D
class_name DraggableRigidBody

@export_group("Physics")
@export var default_gravity_scale = 1.3
@export var pull_force: float = 8
@export var rotation_mult: float = .0005

@onready var held: bool = false;
@onready var velocity: Vector2 = Vector2(0, 0)


func _ready() -> void:
	gravity_scale = default_gravity_scale
	
func _physics_process(_delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position()
	
	
	if held == true:
		#moves the thig directly to the thing
		#if distance between mouse and held object and mouse is
		#greater than radius (circle_size) pull towards object depending on distance
		
		
		
		shitty_physics_b(mouse_position)
	if Input.is_action_just_released("Click"):
		held = false
		gravity_scale = default_gravity_scale
	#physics a
	position += velocity 
	
	
func shitty_physics_b(mouse_position) -> void:
	var direction = (mouse_position - global_position).normalized()
	var distance = global_position.distance_to(mouse_position)
	
	if (distance > 1.5 * GlobalDaniel.circle_size):
		var pull = direction * (distance) * pull_force
		linear_velocity = pull
		angular_velocity += pull.cross(Vector2.UP) * rotation_mult
	elif (distance > GlobalDaniel.circle_size && 
	distance < 1.5 * GlobalDaniel.circle_size):
		var pull = direction * (distance) * (pull_force / 2)
		linear_velocity = pull
		angular_velocity += pull.cross(Vector2.UP) * rotation_mult
	elif (position.distance_to(mouse_position) < GlobalDaniel.circle_size):
		linear_velocity *= .95


func _on_input_event(_viewport: Node, event: InputEvent,_shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		held = true;
		#gravity_scale = 0;
