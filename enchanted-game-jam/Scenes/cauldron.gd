extends StaticBody2D







func _on_area_top_area_entered(area: Area2D) -> void:
	if area.name=='GrabArea2D':
		print("cat is in cauldron")
		area.get_parent().queue_free()
		print("katze weg")
