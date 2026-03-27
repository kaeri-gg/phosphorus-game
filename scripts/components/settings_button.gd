class_name SettingsButton
extends Control

signal on_click

@onready var settings_button: TextureButton = %SettingsButton

func _ready() -> void:
	settings_button.pressed.connect(open_settings)

func open_settings() -> void:
	ui_manager.open_settings_modal()
	sound_manager.play("Click")
	on_click.emit()
