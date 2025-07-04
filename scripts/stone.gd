extends Area2D
class_name Stone

var alive: bool = true
@export var value = 0
@export var last_in_wave = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D


func _physics_process(delta):
	if alive:
		if StatesAndStuff.going_down:
			position.y -= (StatesAndStuff.speed / 3) * delta
		if StatesAndStuff.going_down == false:
			position.y += (StatesAndStuff.speed / 3) * delta
	else:
		if StatesAndStuff.going_down:
			position.y -= (StatesAndStuff.speed / 4.3) * delta

func _on_body_entered(body):
	if body.is_in_group("player"):
		if StatesAndStuff.going_down:
			Utility.frameFreeze(0.05, 0.35)
			SignalBus.stone_destroy.emit(self)
			collision_shape.set_deferred("disabled", true)
			alive = false
		if StatesAndStuff.going_down == false:
			SignalBus.stone_pickup.emit(self)
			queue_free()

func destroy_self():
	queue_free()

func _on_animation_finished():
	if animated_sprite.animation == "Explosion":
		destroy_self()
