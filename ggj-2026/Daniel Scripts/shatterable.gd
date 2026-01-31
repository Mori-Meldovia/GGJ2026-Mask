class_name ShatterableComponent
extends Node

enum fragment_corner {
	TOP_LEFT,
	TOP_RIGHT,
	BOTTOM_LEFT,
	BOTTOM_RIGHT
}
	
	

@onready var parent = get_parent()
@onready var sprite = get_parent().get_node("Sprite2D")

func shatter() -> void:
	for corner in fragment_corner.values():
		var fragment = make_fragment_corner(corner)
		get_node("../../").add_child(fragment)
	get_parent().queue_free()

func make_fragment_corner(corner: fragment_corner) -> DraggableRigidBody:
	var fragment = DraggableRigidBody.new()
	var fragment_sprite = CollisionPolygonSprite2D.new()
	
	fragment_sprite.texture = make_atlas_texture(sprite.texture, corner)
	fragment_sprite.scale = sprite.scale
	
	var fragment_size = fragment_sprite.texture.get_size()

	match corner:
		fragment_corner.TOP_LEFT:
			fragment.position = sprite.global_position - fragment_size / 2
		fragment_corner.TOP_RIGHT:
			fragment.position = sprite.global_position + Vector2(fragment_size.x / 2, -fragment_size.y / 2)
		fragment_corner.BOTTOM_LEFT:
			fragment.position = sprite.global_position  + Vector2(- fragment_size.x / 2, +fragment_size.y / 2)
		fragment_corner.BOTTOM_RIGHT:
			fragment.position = sprite.global_position + fragment_size / 2
	
	if get_parent() is RigidBody2D:
		fragment.linear_velocity = get_parent().linear_velocity
		fragment.angular_velocity = get_parent().angular_velocity
	
	fragment.add_child(fragment_sprite)
	
	return fragment
func make_atlas_texture(texture: Texture2D, corner: fragment_corner) -> AtlasTexture:
	var atlas_texture = AtlasTexture.new()
	var size = Vector2(texture.get_size())

	var region_rect;
	
	match corner:
		fragment_corner.TOP_LEFT:
			region_rect = Rect2(0, 0, size.x / 2, size.y / 2)
		fragment_corner.TOP_RIGHT:
			region_rect = Rect2(size.x / 2, 0, size.x / 2, size.y / 2)
		fragment_corner.BOTTOM_LEFT:
			region_rect = Rect2(0, size.y / 2, size.x / 2, size.y / 2)
		fragment_corner.BOTTOM_RIGHT:
			region_rect = Rect2(size.x / 2, size.y / 2, size.x / 2, size.y / 2)
	
	atlas_texture.atlas = texture
	atlas_texture.region = region_rect
	
	atlas_texture.filter_clip = true
	
	return atlas_texture
	
	
