class_name BurnableObstacle
extends Area2D

enum TYPE { FIRE, FIREWORK, WOOD }

@export var type: TYPE

var _burn_state: int = 0
var _kill_timer: Timer

func _ready() -> void:
	_kill_timer = Timer.new()
	_kill_timer.wait_time = 1.5
	_kill_timer.one_shot = true
	_kill_timer.timeout.connect(_on_kill_timer_timeout)
	add_child(_kill_timer)

func _on_body_entered(player: Node) -> void:
	if player is not Player:
		return

	match type:
		TYPE.FIRE:
			_handle_fire(player)
		TYPE.FIREWORK:
			_handle_firework(player)
		TYPE.WOOD:
			_handle_wood(player)

func _handle_fire(player: Player) -> void:
	_start_kill(player)

func _handle_firework(player: Player) -> void:
	if player.current_state == Player.STATE.BURNING:
		_start_kill(player)

func _handle_wood(player: Player) -> void:
	if player.current_state == Player.STATE.BURNING:
		_start_kill(player)

func _start_kill(_player: Player) -> void:
	if _burn_state != 0:
		return
	_burn_state = 1
	_kill_timer.start()

func _on_kill_timer_timeout() -> void:
	match type:
		TYPE.FIRE:
			pass
		TYPE.FIREWORK:
			print("firework became fire")
			_burn_state = 0
		TYPE.WOOD:
			await utils.timeout(1.0)
			queue_free()
