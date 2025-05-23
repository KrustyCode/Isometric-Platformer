class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.RIGHT
var direction : Vector2 = Vector2.ZERO
var initial_position : Vector2
var platform_velocity
var on_tile : bool = true
var on_moving_tile : bool = false
var on_static_tile : bool = false
var overlapping_areas
#var on_moving_tile : bool = false
@export var MOVEMENT_SPEED : float = 100.0
@export var FRICTION : float = 3.0
@export var ACCELERATION : float = 2.0

@export var GRAVITY : float = 10.0
@onready var ground: TileMapLayer = $"../Ground"


@onready var area_2d: Area2D = $Area2D
@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var indicator: Sprite2D = $Indicator
@onready var state_machine: PlayerStateMachine = $StateMachine


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial_position = global_position
	state_machine.initialize(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	overlapping_areas = area_2d.get_overlapping_areas()

	# Cek apakah masih ada platform yang terdeteksi
	for area in overlapping_areas:
		if area.is_in_group("Tiles"):
			on_moving_tile = true
			on_static_tile = false
		elif area.is_in_group("StaticTiles"):
			on_static_tile = true
			on_moving_tile = false
	if not overlapping_areas:
		on_moving_tile = false
		on_static_tile = false
	if on_tile:
		direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		#print (platform_velocity)
		if not is_player_on_tile() and state_machine.current_state != $StateMachine/Jump:
			if not on_moving_tile and not on_static_tile and state_machine.current_state != $StateMachine/Jump:
				on_tile = false

	#velocity = direction.normalized() * MOVEMENT_SPEED
	
	
			
  # Ambil velocity dari platform
	move_and_slide()

func is_player_on_tile() -> bool:
	
	var center_position = global_position + Vector2(0, 2)
	var top = global_position + Vector2(0, -4)
	var bottom = global_position + Vector2(0, 4)
	var left = center_position + Vector2(-4, 0)
	var right = center_position + Vector2(4, 0)

	# Get the tile position (row, column) in the isometric grid
	var tile_pos_left = ground.local_to_map(ground.to_local(left))
	var tile_pos_right = ground.local_to_map(ground.to_local(right))
	var tile_pos_top = ground.local_to_map(ground.to_local(top))
	var tile_pos_bottom = ground.local_to_map(ground.to_local(bottom))

	# Check the tile ID at this position
	var tile_id_left = ground.get_cell_source_id(tile_pos_left)
	var tile_id_right = ground.get_cell_source_id(tile_pos_right)
	var tile_id_top = ground.get_cell_source_id(tile_pos_top)
	var tile_id_bottom = ground.get_cell_source_id(tile_pos_bottom)
	
	#if direction != Vector2.ZERO:
		#print("left : " + str(tile_pos_left))
		#print("right : " + str(tile_pos_right))
		#print("top : " + str(tile_pos_top))
		#print("bottom : " + str(tile_pos_bottom))
	# Return true if the tile ID is valid (not empty)
	return false if tile_id_left == -1 and tile_id_right == -1 and tile_id_top == -1 and tile_id_bottom == -1 else true

	
	

func set_direction()->bool:
	var new_direction: Vector2 = cardinal_direction
	
	if direction == Vector2.ZERO:
		return false
	
	if direction.x < 0:
		new_direction = Vector2.LEFT
	elif direction.x > 0:
		new_direction = Vector2.RIGHT
	
	if new_direction == cardinal_direction:
		return false
	
	cardinal_direction = new_direction
	if cardinal_direction == Vector2.LEFT:
		indicator.scale.x = -1
		player_sprite.scale.x = -1
	else:
		indicator.scale.x = 1
		player_sprite.scale.x = 1
	
	return true

func respawn_player()->void:
	on_tile = true
	top_level = true
	velocity = Vector2.ZERO
	direction = Vector2.ZERO
	global_position = initial_position

func update_animation( state : String ):
	animation_player.play(state)


#func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.is_in_group("Tiles"):
		#print("Masuk Tiles Cik")
		#on_moving_tile = true# Replace with function body.
#
#
#func _on_area_2d_area_exited(area: Area2D) -> void:
	#if area.is_in_group("Tiles"):
		#print("Keluar Tiles Cik")
		#on_moving_tile = false # Replace with function body.
