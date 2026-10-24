extends CharacterBody2D

@export var speed: int = 600
@export var acceleration: int = 10000
@export var jump_speed: int = 900
@export var gravity: int = 1500
@export var coyote_time: float = 0.08
@export var max_jump_height: float = 4069.0 
@export var throw_force: float = 600
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const PUSH_FORCE: float = 30.0
const MIN_PUSH_FORCE: float = 5

# Variable für Coyote Time
var coyote_timer: float = 0.0
var wirklich_auf_boden: bool = false
var war_vorher_auf_boden: bool = true # Wichtig, um den Lande-Moment zu erkennen

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	# 1. Schwerkraft zuerst anwenden (wenn nicht auf dem Boden)
	if not wirklich_auf_boden:
		velocity.y += gravity * delta

	handle_input()
	move_and_slide()
	
	# Zustand von vorher sichern, BEI DER BODENPRÜFUNG ändert sich 'wirklich_auf_boden'
	war_vorher_auf_boden = wirklich_auf_boden
	
	pruefe_echten_boden()
	update_coyote_timer(delta)
	push()
	
	# Animationen basierend auf dem aktuellen Zustand aktualisieren
	update_animations()

func pruefe_echten_boden() -> void:
	wirklich_auf_boden = is_on_floor()
	
	if wirklich_auf_boden:
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			
			# Katze und Kessel komplett als Boden ausschließen
			if collider and (collider.name == "Cat" or collider.is_in_group("cat") or collider.name == "cauldron" or collider.is_in_group("cauldron")): 
				wirklich_auf_boden = false
				break

func handle_input() -> void:
	# Normaler, sauberer Godot-Sprungimpuls
	if Input.is_action_just_pressed("Up") and coyote_timer > 0.0:
		velocity.y = -jump_speed
		coyote_timer = 0.0 

	# Variabler Sprung: Wenn man die Taste loslässt, bricht der Sprung ab
	if Input.is_action_just_released("Up") and velocity.y < 0:
		velocity.y = velocity.y * 0.5

	# Horizontale Bewegung
	var direction := Input.get_axis("Left", "Right")
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, acceleration)
	else:
		velocity.x = move_toward(velocity.x, speed * direction, acceleration)
		if direction < 0:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false

func update_coyote_timer(delta: float) -> void:
	if wirklich_auf_boden:
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta

func update_animations() -> void:
	# 1. LANDING: Wenn wir gerade gelandet sind (vorher in der Luft, jetzt auf dem Boden)
	if wirklich_auf_boden and not war_vorher_auf_boden:
		if animated_sprite.sprite_frames.has_animation("landing"):
			animated_sprite.play("landing")
			return # Landung hat Priorität, damit sie kurz abgespielt wird

	# Wenn die Lande-Animation noch läuft, unterbrechen wir sie erst, wenn sie fertig ist 
	# (optional: falls du willst, dass sie komplett durchläuft)
	if animated_sprite.animation == "landing" and animated_sprite.is_playing():
		return

	# 2. LUFT-ZUSTÄNDE (Springen / Fallen)
	if not wirklich_auf_boden:
		if velocity.y < 0:
			# Bewegt sich nach oben -> Sprung (Windup / Aufstieg)
			if animated_sprite.sprite_frames.has_animation("jump"):
				animated_sprite.play("jump")
		else:
			# Bewegt sich nach unten -> Fallen
			if animated_sprite.sprite_frames.has_animation("falling"):
				animated_sprite.play("falling")
	
	# 3. BODEN-ZUSTÄNDE (Laufen / Idle)
	else:
		var direction := Input.get_axis("Left", "Right")
		if direction != 0:
			if animated_sprite.sprite_frames.has_animation("walk"):
				animated_sprite.play("walk")
			elif animated_sprite.sprite_frames.has_animation("run"):
				animated_sprite.play("run")
		else:
			if animated_sprite.sprite_frames.has_animation("idle"):
				animated_sprite.play("idle")

#leos code
func _on_cat_detection_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("get_grabbed"):
		var grabbed = area.get_parent().get_grabbed()
		if grabbed:
			print("Player grabbed the cat!")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("throw") and has_node("Cat"):
		throw_cat()		
		
func throw_cat() -> void:
	var cat = get_node("Cat")
	if cat:
		cat.reparent(get_parent())
	var throw_direction = Vector2.RIGHT
	if animated_sprite.flip_h:
		throw_direction = Vector2.LEFT
	throw_direction.y = -0.5  # Leichter Aufwärtswinkel beim Werfen
	if cat.has_method("launch"):
		cat.launch(throw_direction * throw_force)
		print("player throwed cat")


func push()-> void:
	for i in get_slide_collision_count():
		var collisions= get_slide_collision(i)
		if collisions.get_collider() is RigidBody2D:
			var push_force = (PUSH_FORCE* velocity.length()/speed) + MIN_PUSH_FORCE
			collisions.get_collider().apply_central_impulse(-collisions.get_normal()*PUSH_FORCE)
		
