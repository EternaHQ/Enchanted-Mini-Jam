extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var grab_area = $GrabArea2D
@onready var timer: Timer = $Timer

var is_flying: bool = false
var is_running: bool = true
var player: CharacterBody2D
var gravity: float = 5.0
var speed: int=10
var acceleration=100
var movement_direction=0
var is_grabbed: bool=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if is_grabbed:
		velocity = (player.global_position + Vector2(0,-100) - global_position) * 10
		move_and_slide()
	else:
		movement()
		if !is_on_floor():
			velocity.y += gravity
		if is_on_floor():
			velocity.y = 0
		move_and_slide()

func _on_grab_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("test")
		is_grabbed = true
		animated_sprite.play("grabbed")
		collision_shape.disabled = false
		collision_shape.set_deferred("disabled", true)
		grab_area.set_deferred("monitorable", true)  

func movement() -> void:
	pass

func throw() -> void:
	pass