extends StaticBody2D
var level=1

var Level1 = "res://Scenes/Level1.tscn"
var Level2 = "res://Scenes/Level2.tscn"
var Level3 = "res://Scenes/Level3.tscn"
func _physics_process(delta: float) -> void:
	pass
var next_level
func _ready() -> void:
	if Gloabl.current_scene==1:
		next_level=Level2
	if Gloabl.current_scene==2:
		next_level=Level3




func _on_area_top_area_entered(area: Area2D) -> void:
	

	if area.name=='GrabArea2D':
		print("cat is in cauldron")
		area.get_parent().queue_free()
		get_tree().change_scene_to_file(next_level)
		Gloabl.current_scene+=1
# Replace with function body.

func _on_downward_pull_body_entered(body: Node2D) -> void:
	if body.is_in_group("cat"):
		body.in_downward_pull = true


func _on_downward_pull_body_exited(body: Node2D) -> void:
	if body.is_in_group("cat"):
		body.in_downward_pull = false
