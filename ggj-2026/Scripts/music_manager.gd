extends Node

const level = preload("res://Assets/Soundtrack/PackingPartsSoundtrack.mp3")

@onready
var MusicPlayer: AudioStreamPlayer2D = %MainSoundtrack

func _ready() -> void:
	MusicPlayer.volume_db = -10.0
	MusicPlayer.play()

func _on_main_soundtrack_finished() -> void:
	MusicPlayer.play()
