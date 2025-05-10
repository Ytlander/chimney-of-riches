extends ParallaxBackground
@onready var game_manager = %GameManager

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_manager.going_down:
		scroll_base_offset.y -= game_manager.speed * delta
	if game_manager.going_down == false:
		scroll_base_offset.y += game_manager.speed * delta
