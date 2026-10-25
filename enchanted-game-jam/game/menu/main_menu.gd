extends Control

func _on_play_button_pressed() -> void:
	Audio.get_node("klick_sound").play()
	get_tree().change_scene_to_file("res://game/level_1/Level1.tscn")


func _on_quit_button_pressed() -> void:
	Audio.get_node("klick_sound").play()
	get_tree().quit()

func _on_instruction_pressed() -> void:
	Audio.get_node("klick_sound").play()
	get_tree().change_scene_to_file("res://game/menu/Instruction.tscn")


func _on_back_pressed() -> void:
	Audio.get_node("klick_sound").play()
	get_tree(). change_scene_to_file("res://game/menu/Main.tscn")


func _on_endless_button_pressed() -> void:
	Audio.get_node("klick_sound").play()
	Gloabl.current_scene = -1
	get_tree(). change_scene_to_file("res://game/level_-1/Level-1.tscn")
