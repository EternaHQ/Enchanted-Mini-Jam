extends Node2D

@onready var animation_player: AnimationPlayer =$body/AnimationPlayer
#

func start_move() -> void:
	animation_player.play("move")
func close() -> void:
	animation_player.play("close")
