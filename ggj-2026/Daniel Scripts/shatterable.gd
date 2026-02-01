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
	
	GlobalDaniel.num_items += 3
	for corner in fragment_corner.values():
		var fragment = make_fragment_corner(corner)
		get_node("../../").add_child(fragment)
	get_parent().queue_free()

func make_fragment_corner(corner: fragment_corner) -> DraggableRigidBody:
	var fragment = DraggableRigidBody.new()
	var fragment_sprite = CollisionPolygonSprite2D.new()
	
	fragment_sprite.texture = make_atlas_texture(sprite.texture, corner)
	fragment_sprite.texture_filter = sprite.texture_filter
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
	fragment.add_to_group("Item")
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
	
	var trimmed_region = get_opaque_bounds(texture, region_rect)
	
	atlas_texture.atlas = texture
	atlas_texture.region = trimmed_region
	atlas_texture.filter_clip = true
	
	return atlas_texture
	
func get_opaque_bounds(texture: Texture2D, region: Rect2) -> Rect2:
	var image = texture.get_image()
	
	var min_x = region.size.x
	var max_x = 0.0
	var min_y = region.size.y
	var max_y = 0.0
	

	for x in range(region.position.x, region.position.x + region.size.x):
		for y in range(region.position.y, region.position.y + region.size.y):
			if image.get_pixel(x, y).a > 0.1:
				min_x = min(min_x, x - region.position.x)
				max_x = max(max_x, x - region.position.x)
				min_y = min(min_y, y - region.position.y)
				max_y = max(max_y, y - region.position.y)
	
	return Rect2(
		region.position.x + min_x,
		region.position.y + min_y,
		max_x - min_x,
		max_y - min_y
	)
