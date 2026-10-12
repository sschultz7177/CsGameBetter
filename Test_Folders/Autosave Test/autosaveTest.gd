extends Node2D # Or Node2D, depending on your root node type

# Create a variable to keep track of the count
var count: int = 0

# Drag and drop your Label from the Scene tree into the script while holding Ctrl
# to create an @onready reference automatically.
@onready var label: Label = $Label

func _ready() -> void:
	var dict: Dictionary = AutosaveScript.load_game()
	count = dict["Clicks:"]
	# Set the initial text when the game starts
	update_label()

# A function to update the text display
func update_label() -> void:
	label.text = "Count: " + str(count)

func _on_button_pressed() -> void:
	count += 1      # Add 1 to the current count
	update_label()  # Update the display text
func _exit_tree() -> void:
	AutosaveScript.save_game({"Clicks:": count})
