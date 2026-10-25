extends Area2D

@export var moving_platform: Node2D

func _on_body_entered(body: Node2D) -> void:
	if moving_platform:
		moving_platform.start_move()
	else:
		print("ups")


func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
