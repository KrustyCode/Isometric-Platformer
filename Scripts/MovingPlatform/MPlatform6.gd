class_name MovingPlatform_6 extends MovingPlatform


func platform_animation():
	var tween = create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_interval(3)
	tween.tween_property(self, "global_position", Vector2(18, -1112), 4.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_interval(3)
	tween.tween_property(self, "global_position", Vector2(-286, -960), 4.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	tween.set_loops()



func _on_area_2d_area_entered(area: Area2D) -> void:
	player_entered(area)


func _on_area_2d_area_exited(area: Area2D) -> void:
	player_exited(area)
