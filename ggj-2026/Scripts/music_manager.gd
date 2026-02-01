extends Node

@onready
var MusicPlayer: AudioStreamPlayer2D = %MainSoundtrack

@onready
var itemBreak: AudioStreamPlayer2D = %ItemBreaking

@onready
var boxBell: AudioStreamPlayer2D = %BoxAssends

func _ready() -> void:
	MusicPlayer.volume_db = -10.0
	MusicPlayer.play()

func _on_main_soundtrack_finished() -> void:
	MusicPlayer.play()

func play_broken_sound() -> void:
	itemBreak.play()

func play_box_complete() -> void:
	boxBell.play()
