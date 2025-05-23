class_name MovingCollapsePlatform_7 extends CollapsePlatform

func platform_animation():
	var moving_tween = create_tween()
	moving_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	moving_tween.tween_property(self, "global_position", Vector2(-718, -856), 2.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	await moving_tween.finished
	
	moving_tween = create_tween()
	moving_tween.tween_property(self, "global_position", Vector2(-526, -952), 6.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	moving_tween.tween_property(self, "global_position", Vector2(-334, -856), 6.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	moving_tween.tween_property(self, "global_position", Vector2(-526, -760), 6.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	moving_tween.tween_property(self, "global_position", Vector2(-718, -856), 6.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	
	moving_tween.set_loops()


func _on_area_2d_area_entered(area: Area2D) -> void:
	player_entered(area)
	disappear(4)
	
func _on_area_2d_area_exited(area: Area2D) -> void:
	player_exited(area)
