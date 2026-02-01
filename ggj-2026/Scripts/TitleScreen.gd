extends Control

func _ready() -> void:
	$SettingsMenu/Fullscreen.button_pressed = true if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN else false
	$SettingsMenu/MainVolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$SettingsMenu/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	$SettingsMenu/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

func _on_start_pressed() -> void:
<<<<<<< Updated upstream
	get_tree().change_scene_to_file("res://Scenes/level1.tscn")
=======
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
>>>>>>> Stashed changes


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	$SettingsMenu.visible = true
	$MainButtons.visible = false


func _on_credits_pressed() -> void:
	$CreditsMenu.visible = true
	$MainButtons.visible = false


func _on_back_pressed() -> void:
	$CreditsMenu.visible = false
	$SettingsMenu.visible = false
	$MainButtons.visible = true


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_main_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), value)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)
