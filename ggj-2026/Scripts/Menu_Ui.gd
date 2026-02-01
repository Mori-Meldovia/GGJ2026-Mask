extends Control

var level_complete: bool = false

func _ready() -> void:
	visible = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Menu"):
		if visible:
			visible = false
		else:
			visible = true


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")

func _on_next_pressed() -> void:
	if level_complete:
		get_tree().change_scene_to_file("res://Scenes/level" + str(LevelSelector.currentLevel) + ".tscn")

func _on_level_complete() -> void:
	$Control/VBoxContainer/ButtonContainer/Next.icon = load("res://Assets/MenuUI/WhiteArrow.webp")
	LevelSelector.currentLevel += 1
	visible = true
	level_complete = true

func _on_level_failure() -> void:
	visible = true
