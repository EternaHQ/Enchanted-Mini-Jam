extends LineEdit



func _on_text_submitted(new_text: String) -> void:
	get_tree().change_scene_to_file("res://game/level_" + str(new_text) + "/Level" + str(new_text) + ".tscn")
