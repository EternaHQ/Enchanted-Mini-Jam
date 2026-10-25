extends Area2D

@export var moving_platform: Node2D
@export var Klappe: Node2D
func _on_body_entered(body: Node2D) -> void:
	if Gloabl.current_scene==3:
		if moving_platform:
			moving_platform.start_move()
		else:
			print("ups")
	elif Gloabl.current_scene==4:
		if Klappe:
			Klappe.start_move()
		

func _on_body_exited(body: Node2D) -> void:
	if Gloabl.current_scene==3:
		if moving_platform:
			moving_platform.close()
		else:
			print("ups")
	elif Gloabl.current_scene==4:
		if Klappe:
			Klappe.close()
