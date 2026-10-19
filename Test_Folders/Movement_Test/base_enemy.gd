extends CharacterBody2D

const SPEED = 300
const STOP_DISTANCE = 400
enum State {Idle, Walk, Attack}
var current_state : State

# This creates a slot in the Godot inspector panel
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var unit: CharacterBody2D

func _ready():
	current_state = State.Idle

func _physics_process(delta: float):
	if not unit:
		enemy_idle()
		move_and_slide()
		return
		
	var dist : float = global_position.distance_to(unit.global_position)
	
	if dist > STOP_DISTANCE:
		var move_direction: Vector2 = global_position.direction_to(unit.global_position)
		enemy_walk(move_direction)
	else:
		enemy_attack()
	
	move_and_slide()

func enemy_idle():
	velocity = Vector2.ZERO
	current_state = State.Idle
	animated_sprite.play("idle")

func enemy_walk(move_direction: Vector2):
	velocity = move_direction * SPEED
	current_state = State.Walk
	animated_sprite.play("move")

func enemy_attack():
	velocity = Vector2.ZERO
	current_state = State.Attack
	animated_sprite.play("attack")
