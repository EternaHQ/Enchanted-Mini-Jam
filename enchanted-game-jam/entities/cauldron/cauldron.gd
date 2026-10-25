extends StaticBody2D
var level=1

var Level1 = "res://game/level_1/Level1.tscn"
var Level2 = "res://game/level_2/Level2.tscn"
var Level3 = "res://game/level_3/Level3.tscn"
var Level4 = "res://game/Level4/Level4.tscn"

var current_scene_file

var next_level
func _ready() -> void:
	if Gloabl.current_scene==1:
		next_level=Level2
		current_scene_file=Level1
	if Gloabl.current_scene==2:
		next_level=Level3
		current_scene_file=Level2
	if Gloabl.current_scene==3:
		next_level=Level4
		current_scene_file=Level3
	if Gloabl.current_scene==4:
		current_scene_file=Level4
	if Gloabl.current_scene==5:
		next_level="res://game/menu/Main.tscn"

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Reset"):
		get_tree().change_scene_to_file(current_scene_file)

func _on_area_top_area_entered(area: Area2D) -> void:
	

	if area.name=='GrabArea2D':
		print("cat is in cauldron")
		area.get_parent().queue_free()
		get_tree().change_scene_to_file(next_level)
		Gloabl.current_scene+=1


func _on_downward_pull_body_entered(body: Node2D) -> void:
	if body.is_in_group("cat"):
		body.in_downward_pull = true


func _on_downward_pull_body_exited(body: Node2D) -> void:
	if body.is_in_group("cat"):
		body.in_downward_pull = false
