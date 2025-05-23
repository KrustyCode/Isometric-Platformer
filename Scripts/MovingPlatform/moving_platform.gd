class_name MovingPlatform extends CharacterBody2D

var previous_position: Vector2
var player_on_tile : bool = false
@export var MOVEMENT_SPEED : float = 100.0
@export var FRICTION : float = 5.0
@export var ACCELERATION : float = 2.5
@onready var ground: Node2D = $"../Ground"
@onready var player: Player = $"../Player"

func _ready() -> void:
	previous_position = position
	platform_animation()

func _physics_process(delta: float) -> void:
	velocity = (position - previous_position) / delta

	if player_on_tile:
		player.platform_velocity = velocity
		
		if player.state_machine.current_state is not StatePlayerFalling and player.state_machine.current_state is not StatePlayerJump:
			if player.direction != Vector2.ZERO:
				player.velocity = velocity + (player.velocity - velocity).move_toward(MOVEMENT_SPEED * player.direction.normalized(), ACCELERATION)
			else:
				var player_friction = (player.velocity - velocity).move_toward(velocity, FRICTION)
				if player_friction == Vector2.INF:
					player.velocity = velocity + player_friction
				else:
					player.velocity = velocity
				player.direction = Vector2.ZERO

	previous_position = position


func player_entered(area: Area2D)->void:
	if area.is_in_group("Player") and player.state_machine.current_state is not StatePlayerFalling:
		player_on_tile = true
		print("masuk aselole")

func player_exited(area: Area2D)->void:
	if area.is_in_group("Player") or player.state_machine.current_state is StatePlayerFalling:
		player_on_tile = false

		
func platform_animation():
	pass

func disappear(loops : int):
	pass
	
