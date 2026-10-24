extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var grab_area = $GrabArea2D
@onready var timer: Timer = $Timer

var player: CharacterBody2D
var gravity: float = 60.0
var is_grabbed: bool = false
var just_launched = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if is_grabbed:
		velocity = (player.global_position + Vector2(0, -100) - global_position) * 10
		move_and_slide()
	else:
		if !just_launched and randf_range(0,120) == 120:
			movement()
		if ! is_on_floor():
			velocity.y += gravity
		if is_on_floor():
			velocity.y = 0

	if Input.is_action_just_pressed("throw"):
		is_grabbed = false

		just_launched = true
		collision_shape.set_deferred("disabled", false)
		grab_area.set_deferred("monitorable", true)
		velocity *= 4
		await get_tree().create_timer(2).timeout
		just_launched = false
		animated_sprite.play("walk")

	move_and_slide()

func _on_grab_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("test")
		is_grabbed = true
		animated_sprite.play("grabbed")
		collision_shape.set_deferred("disabled", true)
		grab_area.set_deferred("monitorable", false)

func movement() -> void:
	pass
