class_name Killzone
extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(player: Node) -> void:
	print("obstacle touched")
	if player is Player:
		if not player.died.is_connected(_on_player_died):
			player.died.connect(_on_player_died)
		player.die()

func _on_player_died() -> void:
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()
