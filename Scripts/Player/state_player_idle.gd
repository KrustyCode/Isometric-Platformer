class_name StatePlayerIdle extends State

@onready var walk: StatePlayerWalk = $"../Walk"
@onready var jump: StatePlayerJump = $"../Jump"
@onready var falling: StatePlayerFalling = $"../Falling"

@export var FRICTION : float = 5.0

func enter() -> void:
	print("idle cik")
	player.update_animation("idle") 
	pass

func exit() -> void:
	pass
	
func process(_delta : float) -> State:
	if not player.on_tile:
		return falling
	if player.direction != Vector2.ZERO:
		return walk
	return null

func physics(_delta : float) -> State:
	#player.velocity = Vector2.ZERO
	if Input.is_action_just_pressed("jump") and player.on_tile:
		return jump
	return null

func handle_input(_event : InputEvent) -> State:
	return null
	
