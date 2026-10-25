extends Node2D

@onready var animation_player: AnimationPlayer = $AnimatableBody2D/AnimationPlayer



func start_move() -> void:
	animation_player.play("Open")
func close() -> void:
	animation_player.play("Close")
