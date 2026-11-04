extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu_Folders/Main_Menu/main_menu.tscn")


func _on_planet_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Planets/Planet 1/P1 map.tscn")


func _on_planet_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Planets/Planet 2/P2 map.tscn")


func _on_planet_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Planets/Planet 3/P3 map.tscn")
