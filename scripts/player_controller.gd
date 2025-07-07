extends CharacterBody2D
@export var speed = 150
var acceleration = 2200
var deceleration = acceleration / speed

func _ready():
	SignalBus.player_speed_change.connect(_on_player_speed_change)
	speed = StatesAndStuff.player_speed

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	
	#Acceleration
	velocity.x += direction.x * acceleration * delta
	#Increasing Y velocity a little bit more for snappier up and down movement
	velocity.y += direction.y * 1.5 * acceleration * delta
	#Deceleration
	velocity -= velocity * deceleration * delta

	move_and_slide()
	
func _on_player_speed_change():
	speed = StatesAndStuff.player_speed
	deceleration = acceleration / speed
	
