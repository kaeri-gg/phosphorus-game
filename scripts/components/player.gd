class_name Player
extends CharacterBody2D

@onready var player_sprite: AnimatedSprite2D = $PlayerSprite

# @onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var SPEED = 400.0
@export var JUMP_VELOCITY = -800.0

signal is_stable
signal is_burning
signal is_shaking

signal is_dead
signal is_evolved

enum STATE { STABLE, BURNING, SHAKING, DEAD, EVOLVED }
enum ENV { AIR, WATER }

var current_state: STATE = STATE.STABLE
var env_state: ENV = ENV.WATER

func _ready() -> void:
	add_to_group("can_interact_with_water")

func change_state(new_state: STATE) -> void:
	if current_state == new_state: return
	current_state = new_state
# Emit corresponding signal
	match new_state:
		STATE.STABLE: 
			is_stable.emit()
		STATE.BURNING: 
			is_burning.emit()
		STATE.SHAKING: 
			is_shaking.emit()
		STATE.DEAD: 
			is_dead.emit()
		STATE.EVOLVED: 
			is_evolved.emit()

func _physics_process(delta: float) -> void:
	# Detect environment state
	_detect_environment()

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	flip_char_on_move()

func _detect_environment() -> void:
	var new_env_state : ENV = env_state
	var new_state := current_state

	# Check environment: AIR, or WATER
	if is_on_floor():
		new_env_state = ENV.AIR
		new_state = STATE.SHAKING
		player_sprite.play("shaking")
		
		utils.timeout(10)
		new_state = STATE.BURNING
		player_sprite.play("burning")
		
	elif not is_on_floor():
		# can be in the water or jumping.
		new_env_state = ENV.WATER
		new_state = STATE.STABLE
		player_sprite.play("stable")

	# Only print and change state if something changed
	if new_env_state != env_state:
		env_state = new_env_state
		match env_state:
			ENV.AIR:
				print("AIR - Player: SHAKING...")
				print("AIR - Player: BURNING...")
			
			ENV.WATER:
				print("WATER - Player: STABLE...")

	if new_state != current_state:
		change_state(new_state)

func flip_char_on_move() -> void:
	if velocity.x > 0:
		player_sprite.flip_h = false
	if velocity.x < 0:	
		player_sprite.flip_h = true
		
