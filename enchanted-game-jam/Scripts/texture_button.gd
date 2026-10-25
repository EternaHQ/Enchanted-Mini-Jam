extends TextureButton
@onready var label_2: Label = $"../Label2"
@onready var label_3: Label = $"../Label3"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	label_2.position.y += 20
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/Level1.tscn")
	

func _on_texture_button_2_pressed() -> void:
	label_3.position.y += 20
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
