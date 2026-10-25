extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Audio.get_node("win").play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/menu/Main.tscn") # Replace with function body.
