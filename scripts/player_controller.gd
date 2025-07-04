extends CharacterBody2D
@export var Speed = 150

func _ready():
	SignalBus.player_speed_change.connect(_on_player_speed_change)
	Speed = StatesAndStuff.player_speed

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("left", "right")
	var directionY = Input.get_axis("up", "down")
	
	velocity.x = directionX
	velocity.y = directionY * 1.5
	
	if velocity.length() > 0:
		velocity *= Speed
		
	move_and_slide()
	
func _on_player_speed_change():
	Speed = StatesAndStuff.player_speed
	
