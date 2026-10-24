extends StaticBody2D
var level=1
func _physics_process(delta: float) -> void:
	pass






func _on_area_top_area_entered(area: Area2D) -> void:
	if area.name=='GrabArea2D':
		print("cat is in cauldron")
		area.get_parent().queue_free()
		print("katze weg")
		get_tree().change_scene_to_file("res://Scenes/Level1.tscn")
