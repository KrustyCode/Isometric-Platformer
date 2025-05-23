class_name CollapsePlatform_5 extends CollapsePlatform


func _on_area_2d_area_entered(area: Area2D) -> void:
	player_entered(area)
	disappear(4)


func _on_area_2d_area_exited(area: Area2D) -> void:
	player_exited(area)
