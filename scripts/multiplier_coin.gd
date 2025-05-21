extends Area2D

@export var multiplier_increase:float = 0.1

func _ready():
	SignalBus.going_up.connect(_on_going_up)

func _physics_process(delta):
	if StatesAndStuff.going_down:
		position.y -= (StatesAndStuff.speed / 3) * delta
	if StatesAndStuff.going_down == false:
		position.y += (StatesAndStuff.speed / 3) * delta

func _on_body_entered(body):
	if body.is_in_group("player"):
		if StatesAndStuff.going_down:
			SignalBus.coin_pickup.emit(multiplier_increase)
			queue_free()

func _on_going_up():
	queue_free()
