extends Node

@onready var timer = $Timer
@export var chimney_length:int = 30

func _ready():
	round_start()

func _process(delta):
	pass
	
func _on_timer_timeout():
	StatesAndStuff.going_down = false

func round_start():
	StatesAndStuff.going_down = true
	timer.wait_time = chimney_length
	timer.start()
