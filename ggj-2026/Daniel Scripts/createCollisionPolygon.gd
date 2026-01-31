class_name CollisionPolygonSprite2D
extends Sprite2D

func _ready() -> void:
	sprite_to_polygon()
	

func sprite_to_polygon() -> void:
	var image = texture.get_image()
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(image)
	
	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2(0, 0), bitmap.get_size()), 2.0)
	
	for polygon in polygons:
		var collider = CollisionPolygon2D.new()
		var poly_offset = Vector2(bitmap.get_size()) / 2
		var centered_polygon = PackedVector2Array()
		for point in polygon:
			centered_polygon.append(point - poly_offset)
		
		collider.polygon = centered_polygon
		collider.scale = scale
		
		collider.position += position
		if !centered:
			collider.position = poly_offset * scale
		get_parent().add_child.call_deferred(collider)
