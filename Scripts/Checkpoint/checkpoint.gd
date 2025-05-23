extends StaticBody2D

@onready var inactive: TileMapLayer = $Inactive
@onready var active: TileMapLayer = $Active
@onready var ambient_light: PointLight2D = $AmbientLight
@onready var ray_light: CheckPointLight = $RayLight
@onready var player : Player = $"../Player"

var active_flag : bool = false

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if active_flag and player.initial_position != self.global_position:
		deactivate()
		
	
func set_player_respawn() -> void:
	if player.initial_position != self.global_position:
		player.initial_position = self.global_position

func activate() -> void:
	active_flag = true
	inactive.visible = false
	active.visible = true
	ambient_light.visible = true
	ray_light.visible = true

func deactivate() -> void:
	active_flag = false
	inactive.visible = true
	active.visible = false
	ambient_light.visible = false
	ray_light.visible = false
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") and player.state_machine.current_state != StatePlayerFalling:
		set_player_respawn()
		activate()
