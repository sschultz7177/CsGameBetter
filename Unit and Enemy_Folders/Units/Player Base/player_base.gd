extends CharacterBody2D
var money: float = 0.0
var money_per_second: float = 2
var MoneyUpgrade = 1
@onready var label: Label = $MoneyLabel 
@onready var timer: Timer = $MoneyTimer

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	update_money_display()

func _on_timer_timeout() -> void:
		money += money_per_second * MoneyUpgrade
		if money >= 160:
			money = 160
		update_money_display()


func update_money_display() -> void:
	label.text = "Money: $" + str(int(money)) + "/160"
	
const Sword_unit = preload("res://Unit and Enemy_Folders/Units/Sword Unit/sword_unit.tscn")

func _on_money_upgrade_pressed() -> void:
	if money >= 60:
		money -= 60
		MoneyUpgrade += .5

func _on_button_pressed() -> void:
	if money >= 20: 
		money -= 20
		var new_object = Sword_unit.instantiate()
		new_object.scale = Vector2(.33, .33) 
		add_child(new_object)
