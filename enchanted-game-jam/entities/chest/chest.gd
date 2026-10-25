extends RigidBody2D
const chest=preload("res://entities/chest/Chest.tscn")
@onready var node_2d: Node2D = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


var kann_spawnen := true

func _on_pressure_plate_press() -> void:
	if not kann_spawnen:
		return
	kann_spawnen = false

	var instanz = chest.instantiate()
	instanz.position = Vector2(277, -876)
	node_2d.add_child(instanz)

	await get_tree().create_timer(1.0).timeout
	kann_spawnen = true
