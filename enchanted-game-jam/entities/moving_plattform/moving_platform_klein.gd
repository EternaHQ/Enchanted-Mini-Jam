extends Node2D

@onready var animation_player: AnimationPlayer =$body/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressure_plate_press() -> void:
	animation_player.play("move")
	print("hi")
