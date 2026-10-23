extends CharacterBody2D

@export var speed: int = 300
@export var acceleration: int = 10
@export var jump_speed: int = 600
@export var gravity: int = 1500
@export var coyote_time: float = 0.08
@export var max_jump_height: float = 256.0

var coyote_timer: float = 0.0
var jump_start_y: float = 0.0
var is_jumping: bool = false

func _physics_process(delta: float) -> void:
	update_coyote_timer(delta)
	handle_input()
	velocity.y += gravity * delta
	move_and_slide()

func handle_input() -> void:
	# Sprung starten (am Boden oder kurz nach dem Verlassen der Kante)
	if Input.is_action_just_pressed("Up") and coyote_timer > 0.0:
		is_jumping = true
		jump_start_y = global_position.y
		coyote_timer = 0.0

	# Aufwärtsbewegung, solange Taste gehalten und Maximalhöhe nicht erreicht
	if is_jumping:
		var height := jump_start_y - global_position.y
		if Input.is_action_pressed("Up") and height < max_jump_height and not is_on_ceiling():
			velocity.y = -jump_speed
		else:
			is_jumping = false

	var direction := Input.get_axis("Left", "Right")
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, acceleration)
	else:
		velocity.x = move_toward(velocity.x, speed * direction, acceleration)

func update_coyote_timer(delta: float) -> void:
	if is_on_floor() and not is_jumping:
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta

func _on_cat_detection_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("get_grabbed"):
		var grabbed = area.get_parent().get_grabbed()
		if grabbed:
			print("Player grabbed the cat!")
		
		
