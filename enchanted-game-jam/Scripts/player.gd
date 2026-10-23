extends CharacterBody2D
@export var speed:int= 200
@export var acceleration:int=5
@export var jump_speed: int= -speed*2






func _physics_process(delta: float) -> void:
	handle_input()
	move_and_slide()
	
func handle_input() -> void:
	if Input.is_action_just_pressed("Up"):
		velocity.y=jump_speed
	var direction=Input.get_axis("Left","Right")
	print(direction)
	if direction==0:
		velocity.x=move_toward(velocity.x,0, acceleration)
	else:
		velocity.x=move_toward(velocity.x, speed*direction, acceleration)
	
