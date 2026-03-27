class_name CloseButton
extends Control

signal on_click

@onready var close_button: TextureButton = %CloseButton

func _ready() -> void:
	close_button.pressed.connect(close_self)

func close_self() -> void:
	sound_manager.play("Click")
	on_click.emit()
