extends Node2D
const UI = preload("res://Planets/enter_level.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var interaction = UI.instantiate()
	interaction.position = Vector2(1000, 1000)
	get_tree().current_scene.call_deferred("add_child", interaction)
