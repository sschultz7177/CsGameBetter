class_name Health
extends Node

signal on_change (current : int, max : int)
signal on_take_damage ()
signal on_die ()
const win_screen = preload("res://Other_Files/Win Screen/win_screen.tscn")

enum PostDeath {DestroyNode, Lose, Win}
#add win and lose screen
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

func get_health() -> int:
	return current

func die():
	on_die.emit()
	if PostDeathAction == PostDeath.DestroyNode:
		get_parent().queue_free()
	elif PostDeathAction == PostDeath.Lose:
		get_tree().reload_current_scene()
	elif PostDeathAction == PostDeath.Win:
		var new_object = win_screen.instantiate()
		new_object.position = Vector2(1000, 540)
		get_tree().current_scene.call_deferred("add_child", new_object)
		get_parent().queue_free()
