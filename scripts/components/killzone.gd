class_name Killzone
extends Area2D

func _on_body_entered(body: Node) -> void:
	if body is Player and body.has_method("die"):
		body.die()
		body.died.connect(_on_player_died)

func _on_player_died() -> void:
	get_tree().reload_current_scene()
