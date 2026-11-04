extends CharacterBody2D

@export var SPEED: float = 150.0
@export var STOP_DISTANCE: float = 450.0
@export var damage_amount: int = 40

enum State {IDLE, WALK, ATTACK}
var current_state: State = State.IDLE
var current_target: CharacterBody2D = null

@onready var hitbox: Area2D = $Hitbox
@onready var hurtbox: Area2D = $Hurtbox
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_area: Area2D = $DetectionArea
@onready var cooldown: Timer = $AttackCooldown
@onready var health_node = $Health

func _ready() -> void:
	# Clean up scaling factors safely
	var adjust: float = scale.x
	STOP_DISTANCE *= adjust
	SPEED *= adjust
	
	# Connect frame animations securely
	if not animated_sprite.animation_finished.is_connected(_on_animated_sprite_2d_animation_finished):
		animated_sprite.animation_finished.connect(_on_animated_sprite_2d_animation_finished)
	
	# Keep tracking surfaces responsive on startup
	if hitbox:
		hitbox.monitoring = true
		hitbox.monitorable = true
	if hurtbox:
		hurtbox.monitoring = true
		hurtbox.monitorable = true

func _physics_process(_delta: float) -> void:
	# Avoid evaluating state updates if locked in an un-cancelable attack animation frame
	if current_state == State.ATTACK:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	current_target = get_closest_target()
	
	if not current_target:
		velocity = Vector2.ZERO
		current_state = State.IDLE
		animated_sprite.play("idle")
	else:
		var distance_to_target = global_position.distance_to(current_target.global_position)
		if distance_to_target > STOP_DISTANCE:
			var move_direction = global_position.direction_to(current_target.global_position)
			velocity = move_direction * SPEED
			current_state = State.WALK
			animated_sprite.play("move")
		else:
			trigger_attack_sequence()
			
	move_and_slide()

func get_closest_target() -> CharacterBody2D:
	if not detection_area: 
		return null
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

func trigger_attack_sequence() -> void:
	if not cooldown.is_stopped():
		velocity = Vector2.ZERO
		current_state = State.IDLE
		animated_sprite.play("idle")
		return
		
	velocity = Vector2.ZERO
	current_state = State.ATTACK
	animated_sprite.play("attack")
	cooldown.start()

func _on_animated_sprite_2d_animation_finished() -> void:
	if current_state == State.ATTACK:
		current_state = State.IDLE
		animated_sprite.play("idle")

# Deals damage when our Hitbox impacts their Hurtbox
func _on_hitbox_area_entered(area: Area2D) -> void:
	print("Hitbox entered: ", area.name, " on parent: ", area.get_parent().name)
	if area.name == "Hurtbox" or area.is_in_group("hurtbox"):
		var target_parent = area.get_parent()
		if target_parent and target_parent != self:
			var target_health = target_parent.get_node_or_null("Health")
			if target_health and target_health.has_method("take_damage"):
				target_health.take_damage(damage_amount)

# Handles absorbing damage when their Hitbox hits our Hurtbox
func _on_hurtbox_area_entered(area: Area2D) -> void:
	print("Hurtbox received hit from: ", area.name)
	if area.name == "Hitbox" or area.is_in_group("hitbox"):
		var target_parent = area.get_parent()
		if target_parent and target_parent != self:
			if "damage_amount" in target_parent:
				var target_damage = target_parent.damage_amount
				if health_node and health_node.has_method("take_damage"):
					health_node.take_damage(target_damage)
