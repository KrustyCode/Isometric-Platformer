class_name StatePlayerJump extends State
@onready var idle: StatePlayerIdle = $"../Idle"
@onready var walk: StatePlayerWalk = $"../Walk"
@onready var player_sprite: Sprite2D = $"../../PlayerSprite"
@onready var falling: StatePlayerFalling = $"../Falling"
@onready var sfx: AudioStreamPlayer = $SFX

@export var MOVEMENT_SPEED : float = 100.0
@export var FRICTION : float = 5.0
@export var ACCELERATION : float = 2.5

var landing : bool = false

func enter() -> void:
	player.set_direction()
	player.update_animation("jump")
	var tween := get_tree().create_tween()
	sfx.play()
	tween.tween_property(
		player_sprite, "position", Vector2(0, -40), 0.3
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		player_sprite, "position", Vector2(0, -13), 0.2, 
	)
	
	await tween.finished
	landing = true

func exit() -> void:
	pass
	
func process(_delta : float) -> State:
	if landing == true:
		landing = false
		if not player.on_tile:
			return falling
		if player.velocity != Vector2.ZERO:
			return walk
		return idle
	return null

func physics(_delta : float) -> State:
	if player.direction != Vector2.ZERO:
		player.velocity = player.velocity.move_toward(MOVEMENT_SPEED * player.direction.normalized(), ACCELERATION)
	else:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, FRICTION)
	player.set_direction()
	return null

func handle_input(_event : InputEvent) -> State:
	return null
	
