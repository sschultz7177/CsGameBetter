extends Control

var money: float = 0.0
var money_per_second: float = 10.0 # Adjust how much money you get per tick/second

@onready var label: Label = $Label # Change path to match your Label node
@onready var timer: Timer = $Timer

func _ready() -> void:
	# Connect the timer's timeout signal to our function
	timer.timeout.connect(_on_timer_timeout)
	update_money_display()

func _on_timer_timeout() -> void:
	# Increase money (multiply by timer wait time if needed, or add a flat amount)
	money += money_per_second * timer.wait_time
	update_money_display()

func update_money_display() -> void:
	# Cast to int for a clean score, or use floor/round
	label.text = "Money: $" + str(int(money))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
