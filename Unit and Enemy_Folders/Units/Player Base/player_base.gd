extends CharacterBody2D

const Sword_unit = preload("res://Unit and Enemy_Folders/Units/Sword Unit/sword_unit.tscn")



func _on_button_pressed() -> void:
	var new_object = Sword_unit.instantiate()
	
	new_object.scale = Vector2(.33, .33) 
	add_child(new_object)

	
