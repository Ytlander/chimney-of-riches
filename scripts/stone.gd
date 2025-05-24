extends Area2D
class_name Stone

@export var value = 0
@export var last_in_wave = false

func _physics_process(delta):
	if StatesAndStuff.going_down:
		position.y -= (StatesAndStuff.speed / 3) * delta
	if StatesAndStuff.going_down == false:
		position.y += (StatesAndStuff.speed / 3) * delta

func _on_body_entered(body):
	if body.is_in_group("player"):
		if StatesAndStuff.going_down:
			SignalBus.stone_destroy.emit()
			queue_free()
		if StatesAndStuff.going_down == false:
			SignalBus.stone_pickup.emit(self)
			queue_free()
