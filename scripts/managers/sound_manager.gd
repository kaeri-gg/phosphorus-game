class_name SoundManager
extends Node

func play(by_name: String, from: float = 0) -> void:
	var sound: AudioStreamPlayer2D = get_node(by_name)
	
	sound.play(from)

func stop(by_name: String) -> void:
	var sound: AudioStreamPlayer2D = get_node(by_name)
	
	sound.stop()
