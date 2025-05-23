class_name CollapsePlatform extends MovingPlatform

var triggered : bool = false
@onready var collision_polygon_2d: CollisionPolygon2D = $Area2D/CollisionPolygon2D

func disappear(loops : int):
	if not triggered and player.state_machine.current_state is not StatePlayerFalling:
		triggered = true
		#tween.stop()
		var tween = create_tween()
		tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(self, "modulate:a", 0.3, 0.2)  # Transparan
		tween.tween_property(self, "modulate:a", 1.0, 0.2)  # Kembali normal
		tween.set_loops(loops)
		tween.tween_property(self, "modulate:a", 0.0, 0.5)
		await tween.finished
		collision_polygon_2d.disabled = true
		await get_tree().create_timer(3).timeout
		tween = create_tween()
		tween.tween_property(self, "modulate:a", 1.0, 0.5)
		collision_polygon_2d.disabled = false
		triggered = false
