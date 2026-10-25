extends Node2D

@onready var animation_player: AnimationPlayer =$body/AnimationPlayer

func _on_pressure_plate_press() -> void:
	if Gloabl.current_scene==3:
		animation_player.play("move")
	if Gloabl.current_scene==6:
		animation_player.play("move")
		print("hi")

func _on_pressure_plate_unpress() -> void:
	if Gloabl.current_scene==3:
		animation_player.play("close")
	if Gloabl.current_scene==6:
		pass
