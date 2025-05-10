extends Area2D

@export var value = 0

func _physics_process(delta):
	if StatesAndStuff.going_down:
		position.y -= (StatesAndStuff.speed / 2) * delta
	if StatesAndStuff.going_down == false:
		position.y += (StatesAndStuff.speed / 2) * delta

func _on_body_entered(body):
	if body.is_in_group("player"):
		if StatesAndStuff.going_down:
			queue_free()
		if StatesAndStuff.going_down == false:
			StatesAndStuff.money += self.value
			queue_free()
