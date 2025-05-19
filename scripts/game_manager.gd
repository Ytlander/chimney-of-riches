extends Node

@onready var timer = $Timer
@export var chimney_length:int = 30
@onready var start_round_button = %StartRoundButton
@onready var money = $Money

signal round_start_signal
signal round_end_signal

func _ready():
	SignalBus.stone_pickup.connect(_on_stone_pickup)

func _process(delta):
	pass

func _on_stone_pickup(stone):
	StatesAndStuff.money += stone.value
	money.text = str(StatesAndStuff.money)

func _on_timer_timeout():
	if StatesAndStuff.going_down:
		StatesAndStuff.going_down = false
		timer.start()
	
	elif StatesAndStuff.going_down == false:
		start_round_button.visible = true
		round_end_signal.emit()

func round_start():
	StatesAndStuff.going_down = true
	round_start_signal.emit()
	timer.wait_time = chimney_length
	timer.start()

func _on_start_round_button_pressed():
	round_start()
	start_round_button.visible = false
