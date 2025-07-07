extends CharacterBody2D
@export var speed = 150

func _ready():
	SignalBus.player_speed_change.connect(_on_player_speed_change)
	speed = StatesAndStuff.player_speed

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	
	velocity = direction
	velocity.y *= 1.5
	
	velocity *= speed
		
	move_and_slide()
	
func _on_player_speed_change():
	speed = StatesAndStuff.player_speed
	
