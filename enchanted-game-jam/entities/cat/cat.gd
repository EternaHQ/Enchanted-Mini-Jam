extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var grab_area: Area2D = $GrabArea2D
@onready var timer: Timer = $Timer

var player: CharacterBody2D
var gravity: float = 40.0
var downward_pull: float = 200
var is_grabbed: bool = false
var just_launched: bool = false
var in_downward_pull: bool = false
@export var start_still: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")
	add_to_group("cat")

func _physics_process(delta: float) -> void:
	if player == null:
		return
	if is_grabbed:
		velocity = (player.global_position + Vector2(0, -100) - global_position) * 10
		move_and_slide()
	else:
		if ! just_launched and randi_range(0, 30) == 0 and !start_still:
			animated_sprite.play("walk")
			change_movement()
		if ! is_on_floor():
			if in_downward_pull:
				velocity.y += downward_pull
			else:
				velocity.y += gravity
		if is_on_floor():
			velocity.y = 0

		var distance: float = global_position.x - player.global_position.x
		if abs(distance) < 300 and !just_launched:
			if distance > 0:
				velocity.x = abs(velocity.x)
				animated_sprite.flip_h = false
			if distance < 0:
				velocity.x = -abs(velocity.x)
				animated_sprite.flip_h = true

	if Input.is_action_just_pressed("throw"):
		if is_grabbed == true:
			Audio.get_node("throw").play()
			start_still = false
			is_grabbed = false
			just_launched = true
			collision_shape.set_deferred("disabled", false)
			grab_area.set_deferred("monitorable", true)
			velocity *= 4
			await get_tree().create_timer(2).timeout
			if !is_grabbed:
				just_launched = false
				animated_sprite.play("walk")

	move_and_slide()

func _on_grab_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Audio.get_node("pick_up").play()
		is_grabbed = true
		animated_sprite.play("grabbed")
		collision_shape.set_deferred("disabled", true)
		grab_area.set_deferred("monitorable", false)
	

func change_movement() -> void:
	if velocity.x > 0:
		velocity.x = randf_range(-2000, -500)
	if velocity.x < 0:
		velocity.x = randf_range(500, 2000)
	else:
		velocity.x = randf_range(-2000, 2000)
	if velocity.x > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
