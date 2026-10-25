extends LineEdit



func _on_text_submitted(new_text: String) -> void:
	get_tree().change_scene_to_file("res://game/level_" + new_text + "/Level" + new_text + ".tscn")
	Gloabl.current_scene = int(new_text)
