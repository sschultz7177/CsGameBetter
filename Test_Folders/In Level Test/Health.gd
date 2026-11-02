class_name Health
extends Node

signal on_change (current : int, max : int)
signal on_take_damage ()
signal on_die ()

enum PostDeath {DestroyNode, RestartScene}

var current : int
@export var max : int = 100

@export var PostDeathAction : PostDeath

func _ready():
	current = max

func take_damage(amount : int):
	current -= amount
	on_change.emit(current,max)
	on_take_damage.emit()
	
	if current <= 0:
		die()
	

func die():
	on_die.emit()
	if PostDeathAction == PostDeath.DestroyNode:
		get_parent().queue_free()
	elif PostDeathAction == PostDeath.RestartScene:
		get_tree().reload_current_scene()
