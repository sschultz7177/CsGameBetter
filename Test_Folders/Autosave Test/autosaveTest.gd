extends Node2D 

var count: int = 0

@onready var label: Label = $Label

func _ready() -> void:
	var dict: Dictionary = AutosaveScript.load_game()
	count = dict["Clicks:"]
	update_label()

func update_label() -> void:
	label.text = "Count: " + str(count)

func _on_button_pressed() -> void:
	count += 1     
	update_label()  
func _exit_tree() -> void:
	AutosaveScript.save_game({"Clicks:": count})
