extends RigidBody2D
class_name DraggableRigidBody

@export_group("Physics")
@export var default_gravity_scale = 1.3
@export var pull_force: float = 8
@export var rotation_mult: float = .0005

@export_group("Breaking")
@export var shatter_threshold = 500

@onready var held: bool = false;
@onready var velocity: Vector2 = Vector2(0, 0)
@onready var shatter = $ShatterableComponent if has_node("ShatterableComponent") else null

@export_group("Volume")
@export var volume = 2 

func _ready() -> void:
	gravity_scale = default_gravity_scale
	input_pickable = true;
	if (shatter):
		contact_monitor = true;
		max_contacts_reported = 4;
	call_deferred("connect_to_nodes")
	
func connect_to_nodes() -> void:
	if !is_connected("input_event", _on_input_event):
		input_event.connect(_on_input_event)

func _physics_process(_delta: float) -> void:
	var mouse_position = get_global_mouse_position()

	if held == true:
		#moves the thig directly to the thing
		#if distance between mouse and held object and mouse is
		#greater than radius (circle_size) pull towards object depending on distance
		
		drag_physics(mouse_position)
		
		
	if Input.is_action_just_released("Click"):
		held = false
		gravity_scale = default_gravity_scale
	#physics a
	position += velocity 
	
	
func drag_physics(mouse_position) -> void:
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


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if state.get_contact_count() > 0:
		if linear_velocity.length() > shatter_threshold && shatter && !held:
			shatter.shatter()
			
func get_volume():
	return volume
