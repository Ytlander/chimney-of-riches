extends Area2D
@export var multiplier_increase:float = 0.1
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_timer = $AnimationTimer

var animation_cooldown: float


func _ready():
	SignalBus.going_up.connect(_on_going_up)
	animation_cooldown = randf_range(0.5, 3)
	animation_timer.wait_time = animation_cooldown
	animation_timer.start()

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

func _on_animation_timer_timeout():
	animated_sprite.play("shine")
	animation_timer.wait_time = animation_cooldown

func _on_animation_finished():
	if animated_sprite.animation == "shine":
		animated_sprite.play("default")
