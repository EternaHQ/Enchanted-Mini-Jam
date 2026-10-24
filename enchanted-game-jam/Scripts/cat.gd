extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var grab_area = $GrabArea2D
var is_flying: bool = false
var player: CharacterBody2D
var gravity: float = 500.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if is_flying:
		velocity.y += gravity * delta
		move_and_slide()
		if is_on_floor():
			is_flying = false
			velocity = Vector2.ZERO
			landed()


func get_grabbed() -> bool:
	animated_sprite.play("grabbed")
	collision_shape.set_deferred("disabled", true)
	grab_area.set_deferred("monitorable", false)
	call_deferred("_finalize_grab")
	
	return true
func _finalize_grab() -> void:
	reparent(player)
	position = Vector2.ZERO
func launch(init_velocity: Vector2) -> void:
	is_flying = true
	velocity = init_velocity
	await get_tree().create_timer(0.5).timeout
	collision_shape.set_deferred("disabled", false)
	grab_area.set_deferred("monitorable", true)

func landed() -> void:
	animated_sprite.play("walk")
