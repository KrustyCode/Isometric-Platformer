class_name CheckPointLight extends PointLight2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("light_idle")
