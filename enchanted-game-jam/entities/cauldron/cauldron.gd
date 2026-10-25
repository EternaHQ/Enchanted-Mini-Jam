extends StaticBody2D
var level=1

var Level = "res://game/level/Level"

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Reset"):
		get_tree().change_scene_to_file("res://game/level_" + str(Gloabl.current_scene) + "/Level" + str(Gloabl.current_scene) + ".tscn")

func _on_area_top_area_entered(area: Area2D) -> void:
	
	if area.name=='GrabArea2D':
		print("cat is in cauldron")
		area.get_parent().queue_free()
		Gloabl.current_scene += 1
		get_tree().change_scene_to_file("res://game/level_" + str(Gloabl.current_scene) + "/Level" + str(Gloabl.current_scene) + ".tscn")

func _on_downward_pull_body_entered(body: Node2D) -> void:
	if body.is_in_group("cat"):
		body.in_downward_pull = true


func _on_downward_pull_body_exited(body: Node2D) -> void:
	if body.is_in_group("cat"):
		body.in_downward_pull = false
