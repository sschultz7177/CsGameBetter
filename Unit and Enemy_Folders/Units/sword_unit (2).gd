extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	add_to_group("units")

func _physics_process(delta: float) -> void:


	move_and_slide()
