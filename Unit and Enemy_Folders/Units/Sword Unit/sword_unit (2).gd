extends CharacterBody2D

const SPEED = 300
const STOP_DISTANCE = 220
enum State {Idle, Walk, Attack}
var current_state : State

# This creates a slot in the Godot inspector panel
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_area: Area2D = $DetectionArea
var current_target: CharacterBody2D = null

func _ready():
	current_state = State.Idle

func _physics_process(delta: float):
	current_target = get_closest_target()

	if not current_target:
		unit_idle()
		move_and_slide()
		return
		
	var dist : float = global_position.distance_to(current_target.global_position)
	
	if dist > STOP_DISTANCE:
		var move_direction: Vector2 = global_position.direction_to(current_target.global_position)
		unit_walk(move_direction)
	else:
		unit_attack()
	
	move_and_slide()

func get_closest_target() -> CharacterBody2D:
	var overlapping_bodies = detection_area.get_overlapping_bodies()
	var closest_unit: CharacterBody2D = null
	var shortest_distance: float = INF # Start at infinity
	
	for body in overlapping_bodies:
		if body is CharacterBody2D and body != self:
			var distance = global_position.distance_to(body.global_position)
			if distance < shortest_distance:
				shortest_distance = distance
				closest_unit = body
				
	return closest_unit

func unit_idle():
	velocity = Vector2.ZERO
	current_state = State.Idle
	animated_sprite.play("idle")

func unit_walk(move_direction: Vector2):
	velocity = move_direction * SPEED
	current_state = State.Walk
	animated_sprite.play("move")

func unit_attack():
	velocity = Vector2.ZERO
	current_state = State.Attack
	animated_sprite.play("attack")
