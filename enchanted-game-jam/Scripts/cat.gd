extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var grab_area = $GrabArea2D
var is_flying: bool = false
var player: CharacterBody2D
var gravity: float = 800.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if is_flying:
		velocity.y += gravity * delta
		position += velocity * delta
		move_and_slide()
		if position.y >= 0:
			is_flying = false
			velocity = Vector2.ZERO
			position.y = 0


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
	collision_shape.set_deferred("disabled", false)
	grab_area.set_deferred("monitorable", true)
