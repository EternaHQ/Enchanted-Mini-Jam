extends Area2D

@export var moving_platform: Node2D
@export var Klappe: Node2D
signal press
signal unpress


func _on_body_entered(body: Node2D) -> void:
	print("hey")
	press.emit()
		

func _on_body_exited(body: Node2D) -> void:
	unpress.emit()
