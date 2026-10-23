extends CharacterBody2D

var SPEED = 300
var STOP_DISTANCE = 220
enum State {Idle, Walk, Attack}
var current_state : State

const Sword_unit = preload("res://Unit and Enemy_Folders/Units/Sword Unit/sword_unit.tscn")


# 1. FIXED: Changed $Marker3D to $Marker2D to match your 2D project setup
@onready var spawn_point: Marker2D = $Marker2D

func _on_button_pressed() -> void:
	# Instantiate the scene
	var new_object = Sword_unit.instantiate()
	
	# 2. ALTER THE SIZE: Change the scale BEFORE or AFTER adding it to the tree
	# Vector2(1.5, 1.5) makes it 50% larger. Vector2(0.5, 0.5) makes it half size.
	new_object.scale = Vector2(.44, .44) 
	# Add it as a child to the current scene tree	
	add_child(new_object)

func _ready():
	var adjust: float = scale.x
	STOP_DISTANCE *= .44
	SPEED *= .44
	current_state = State.Idle
