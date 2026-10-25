extends Node2D

@onready var animation_player: AnimationPlayer =$body/AnimationPlayer

func _on_pressure_plate_press() -> void:
	animation_player.play("move")


func _on_pressure_plate_unpress() -> void:
	animation_player.play("close")
