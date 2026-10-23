extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_grabbed() -> bool:
	animated_sprite.play("grabbed")
	collision_shape.set_deferred("disabled", true)
	reparent(player)
	position = Vector2.ZERO
	return true