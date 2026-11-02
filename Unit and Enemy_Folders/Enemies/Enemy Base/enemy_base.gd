extends CharacterBody2D

const basic_enemy = preload("res://Unit and Enemy_Folders/Enemies/Basic Enemy/base_enemy.tscn")




func _on_timer_timeout() -> void:
		# Instantiate the scene
	var new_object = basic_enemy.instantiate()
	
	# 2. ALTER THE SIZE: Change the scale BEFORE or AFTER adding it to the tree
	# Vector2(1.5, 1.5) makes it 50% larger. Vector2(0.5, 0.5) makes it half size.
	new_object.scale = Vector2(.44, .44) 
	# Add it as a child to the current scene tree	
	add_child(new_object)
