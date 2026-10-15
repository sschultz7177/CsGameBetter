extends CharacterBody2D

const SPEED = 300 
const STOP_DISTANCE = 50.0 
enum State {Idle, Walk, Attack} # Added Attack state
var current_state : State

# References your sprite. Adjust "$AnimatedSprite2D" if your node has a different name!
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var unit: CharacterBody2D = get_node("../Unit") 

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
		enemy_attack() # Switch to attack when close
	
	move_and_slide()

func enemy_idle():
	velocity = Vector2.ZERO
	current_state = State.Idle
	animated_sprite.play("idle")

func enemy_walk(move_direction: Vector2):
	velocity = move_direction * SPEED
	current_state = State.Walk
	animated_sprite.play("walk")


func enemy_attack():
	velocity = Vector2.ZERO
	current_state = State.Attack
	animated_sprite.play("attack")
	
