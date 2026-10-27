extends CharacterBody2D

var SPEED = 300
var STOP_DISTANCE = 220
enum State {Idle, Walk, Attack}
var current_state : State

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_area: Area2D = $DetectionArea
@onready var cooldown : Timer = $AttackCooldown

var current_target: CharacterBody2D = null

func _ready():
	var adjust: float = scale.x
	
	STOP_DISTANCE *= adjust
	SPEED *= adjust
	current_state = State.Idle
	animated_sprite.animation_finished.connect(_on_animated_sprite_2d_animation_finished)

func _physics_process(delta: float):
	match current_state:
		State.Attack:

			velocity = Vector2.ZERO
			move_and_slide()
			
		State.Idle, State.Walk:
			current_target = get_closest_target()

			if not current_target:
				unit_idle()
				move_and_slide()
			else:
				var dist : float = global_position.distance_to(current_target.global_position)
				if dist > STOP_DISTANCE:
					var move_direction: Vector2 = global_position.direction_to(current_target.global_position)
					unit_walk(move_direction)
					move_and_slide()
				else:
					unit_attack()

func get_closest_target() -> CharacterBody2D:
	var overlapping_bodies = detection_area.get_overlapping_bodies()
	var closest_unit: CharacterBody2D = null
	var shortest_distance: float = INF
	
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

	if not cooldown.is_stopped():
		unit_idle() 
		return
		

	velocity = Vector2.ZERO
	current_state = State.Attack
	animated_sprite.play("attack")
	cooldown.start() 

func _on_animated_sprite_2d_animation_finished() -> void:
	if current_state == State.Attack:
		current_state = State.Idle
		animated_sprite.play("idle")
