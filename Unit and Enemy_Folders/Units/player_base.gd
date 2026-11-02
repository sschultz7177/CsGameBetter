extends CharacterBody2D

var money: float = 0.0
var money_per_second: float = 1
var MoneyUpgrade = 0
@onready var label: Label = $Label 
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	update_money_display()

func _on_timer_timeout() -> void:
	if  MoneyUpgrade == 0 and money < 80:
		money += money_per_second 
		update_money_display()
	if MoneyUpgrade == 1 and money < 160 :
		money += money_per_second *2
		update_money_display()

func update_money_display() -> void:
	label.text = "Money: $" + str(int(money))
	
const Sword_unit = preload("res://Unit and Enemy_Folders/Units/Sword Unit/sword_unit.tscn")

func _on_money_upgrade_pressed() -> void:
	MoneyUpgrade = 1


func _on_button_pressed() -> void:
	if money >= 20: 
		money -= 20
		var new_object = Sword_unit.instantiate()
		new_object.scale = Vector2(.33, .33) 
		add_child(new_object)
