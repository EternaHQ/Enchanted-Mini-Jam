extends StaticBody2D
var level=1

var Level1="res://Scenes/Level1.tscn"
var Level2="res://Scenes/Level2.tscn"
func _physics_process(delta: float) -> void:
	pass
var current_scene=1
var next_level
func _ready() -> void:
	if current_scene==1:
		next_level=Level2







func _on_area_top_area_entered(area: Area2D) -> void:
	

	if area.name=='GrabArea2D':
		print("cat is in cauldron")
		area.get_parent().queue_free()
		get_tree().change_scene_to_file(next_level)
		current_scene+=1
	 # Replace with function body.
