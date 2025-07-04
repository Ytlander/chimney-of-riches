extends Camera2D

@export var set_shake_strength: float = 60

@export var shake_speed: float = 30
var shake_strength: float = 0
@export var decay_rate: float = 3

@onready var camera = $"."

@onready var noise = FastNoiseLite.new()
#Where we are in the noise, so we can smoothly move through it
var noise_i: float = 0.0
@onready var rand = RandomNumberGenerator.new()

var shake_it: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.stone_destroy.connect(_on_stone_destroy)
	
	noise.seed = rand.randi()
	noise.frequency = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shake_strength = lerp(shake_strength, 0.0, decay_rate * delta)
	
	var shake_offset: Vector2
	
	shake_offset = get_noise_offset(delta, shake_speed, shake_strength)
	

	if shake_strength > 0.1:
		camera.offset = shake_offset
	else:
		camera.offset = Vector2.ZERO


func get_noise_offset(delta: float, speed: float, strength: float) -> Vector2:
	noise_i += delta * speed
	# Set the x values of each call to 'get_noise_2d' to a different value
	# so that our x and y vectors will be reading from unrelated areas of noise
	return Vector2(
		noise.get_noise_2d(1, noise_i) * strength,
		noise.get_noise_2d(100, noise_i) * strength
	)
	
func _on_stone_destroy(stone):
	shake_strength = set_shake_strength
	
