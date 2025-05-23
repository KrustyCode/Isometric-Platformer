class_name StatePlayerFalling extends State

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $"../../VisibleOnScreenNotifier2D"
@onready var idle: StatePlayerIdle = $"../Idle"


func enter() -> void:
	print("jatuh")
	player.velocity.x = 0
	player.top_level = false

func exit() -> void:
	pass
	
func process(_delta : float) -> State:
	return null

func physics(_delta : float) -> State:
	player.velocity.y += 10
	if not visible_on_screen_notifier_2d.is_on_screen():
		#await get_tree().create_timer(1.0).timeout
		await player.respawn_player()
		return idle
	return null

func handle_input(_event : InputEvent) -> State:
	return null
	
