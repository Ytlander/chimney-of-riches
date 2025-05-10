extends Node

@export var speed = 500
@onready var timer = $Timer

var money = 0
var going_down:bool = true
@export var chimney_length:int = 10

func _ready():
	round_start()

func _process(delta):
	pass
	
func _on_timer_timeout():
	going_down = false

func round_start():
	timer.wait_time = chimney_length
	timer.start()
