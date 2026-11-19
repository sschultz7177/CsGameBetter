extends CharacterBody2D

const basic_enemy = preload("res://Unit and Enemy_Folders/Enemies/Basic Enemy/base_enemy.tscn")
@onready var hurtbox: Area2D = $Hurtbox
@onready var timer: Timer = $EnemySpawn
func _ready():
	if hurtbox:
		hurtbox.monitoring = true
		hurtbox.monitorable = true
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	var new_object = basic_enemy.instantiate()
	
	new_object.scale = Vector2(.44, .44) 
	add_child(new_object)
