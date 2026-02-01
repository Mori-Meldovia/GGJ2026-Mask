extends Node

var currentLevel = 1
var maxLevels = 2

func increase_level() -> void:
	if currentLevel < maxLevels:
		currentLevel += 1

func is_last_level() -> bool:
	return currentLevel == maxLevels
