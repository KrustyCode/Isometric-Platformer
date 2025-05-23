class_name MovingPlatform_4 extends MovingPlatform


func platform_animation():
	var tween = create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_interval(1)
	tween.tween_property(self, "global_position", Vector2(784, -776), 3.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_interval(1)
	tween.tween_property(self, "global_position", Vector2(960, -864), 3.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	tween.set_loops()


func _on_area_2d_area_entered(area: Area2D) -> void:
	player_entered(area) # Replace with function body.

func _on_area_2d_area_exited(area: Area2D) -> void:
	player_exited(area) # Replace with function body.
