extends Control

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Map/map.tscn")


func _on_equip_pressed() -> void:
	get_tree().change_scene_to_file("res://Equip/equip.tscn")


func _on_upgrades_pressed() -> void:
	get_tree().change_scene_to_file("res://Upgrades/upgrades.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Settings/settings.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
