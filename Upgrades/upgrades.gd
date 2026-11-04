extends Node
var upgrade: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dict: Dictionary = AutosaveScript.load_game()
	upgrade = dict["upgrade:"]

func _on_test_upgrade_pressed() -> void:
	upgrade += 1     
	print(upgrade)


func _exit_tree() -> void:
	AutosaveScript.save_game({"upgrade:": upgrade})


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu_Folders/Main_Menu/main_menu.tscn")
