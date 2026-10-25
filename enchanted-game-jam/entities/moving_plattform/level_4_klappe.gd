extends Node2D

@onready var animation_player: AnimationPlayer = $AnimatableBody2D/AnimationPlayer



func start_move() -> void:
	animation_player.play("Open")
func close() -> void:
	animation_player.play("Close")


func _on_pressure_plate_press() -> void:
	animation_player.play("Open")


func _on_pressure_plate_unpress() -> void:
	animation_player.play("Close")
