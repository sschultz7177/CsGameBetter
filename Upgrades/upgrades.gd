extends Node
var upgrade: int = 0

func _ready() -> void:
	var dict: Dictionary = AutosaveScript.load_game()
	upgrade = dict["Upgrade:"]

func _on_button_pressed() -> void:
	upgrade += 1     

func _exit_tree() -> void:
	AutosaveScript.save_game({"Upgrade:": upgrade})
