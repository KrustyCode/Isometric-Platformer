class_name MovingCollapsePlatform_1 extends CollapsePlatform

func platform_animation():
	var moving_tween = create_tween()
	moving_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	
	moving_tween.tween_property(self, "global_position", Vector2(-462, -920), 2.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	moving_tween.tween_property(self, "global_position", Vector2(-398, -888), 2.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	moving_tween.set_loops()


func _on_area_2d_area_entered(area: Area2D) -> void:
	player_entered(area)
	disappear(4)
	
func _on_area_2d_area_exited(area: Area2D) -> void:
	player_exited(area)
