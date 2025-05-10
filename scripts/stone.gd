extends Area2D
@onready var game_manager = %GameManager

@export var value = 0

func _physics_process(delta):
	if game_manager.going_down:
		position.y -= (game_manager.speed / 2) * delta
	if game_manager.going_down == false:
		position.y += (game_manager.speed / 2) * delta

func _on_body_entered(body):
	if body.is_in_group("player"):
		if game_manager.going_down:
			queue_free()
		if game_manager.going_down == false:
			game_manager.money += self.value
			queue_free()
