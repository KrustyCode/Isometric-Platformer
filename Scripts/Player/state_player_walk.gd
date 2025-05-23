class_name StatePlayerWalk extends State

@onready var idle: StatePlayerIdle = $"../Idle"
@onready var jump: StatePlayerJump = $"../Jump"
@onready var falling: StatePlayerFalling = $"../Falling"

@export var MOVEMENT_SPEED : float = 100.0
@export var FRICTION : float = 5.0
@export var ACCELERATION : float = 2.5


func enter() -> void:
	if player.set_direction():
		player.update_animation("walk") 
	pass

func exit() -> void:
	pass
	
func process(_delta : float) -> State:
	if not player.on_tile:
		return falling
	if player.direction == Vector2.ZERO and player.velocity == Vector2.ZERO or player.direction == Vector2.ZERO and player.velocity == player.platform_velocity and player.on_moving_tile:
		return idle
	player.set_direction()
	player.update_animation("walk") 
	return null

func physics(_delta : float) -> State:
	if not player.on_moving_tile:
		if player.direction != Vector2.ZERO:
			player.velocity = player.velocity.move_toward(MOVEMENT_SPEED * player.direction.normalized(), ACCELERATION)
		else:
			player.velocity = player.velocity.move_toward(Vector2.ZERO, FRICTION)
	
	if Input.is_action_just_pressed("jump") and player.on_tile:
		return jump
	
	return null

func handle_input(_event : InputEvent) -> State:
	return null
	
