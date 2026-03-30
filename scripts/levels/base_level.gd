class_name BaseLevel
extends Control

@onready var killzone: Killzone = get_node_or_null("Killzone") as Killzone


func _ready() -> void:
	if killzone == null:
		push_warning("Level is missing a Killzone child.")
		return

	killzone.player_entered.connect(_on_killzone_player_entered)


func _on_killzone_player_entered(_player: Player) -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
