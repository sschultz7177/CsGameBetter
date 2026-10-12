extends Button

# Track the current count
var count: int = 0

func _ready() -> void:
	# Update the text to display the initial count on startup
	update_button_text()

func _on_pressed() -> void:
	# Increment the counter by 1
	count += 1
	# Refresh the button's displayed text
	update_button_text()

func update_button_text() -> void:
	text = "Clicks: " + str(count)
