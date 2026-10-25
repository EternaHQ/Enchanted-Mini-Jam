extends Node2D
const cat = preload("res://entities/cat/cat.tscn")

func _ready() -> void:
	print("timer")
	while true:
		await get_tree().create_timer(randf_range(5, 20)).timeout
		add_child(cat.instantiate())
