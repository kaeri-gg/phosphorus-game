class_name Killzone
extends Area2D

signal player_entered(player: Player)

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
		
	Engine.time_scale = 0.5
	player_entered.emit(body)
