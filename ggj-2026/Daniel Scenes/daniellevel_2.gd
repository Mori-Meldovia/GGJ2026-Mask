extends Node2D

@onready var menuUI = $MenuUI

func _process(_delta: float) -> void:
	if (GlobalDaniel.num_items == 0):
		pass
