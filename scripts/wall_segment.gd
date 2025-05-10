extends ParallaxBackground

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if StatesAndStuff.going_down:
		scroll_base_offset.y -= StatesAndStuff.speed * delta
	if StatesAndStuff.going_down == false:
		scroll_base_offset.y += StatesAndStuff.speed * delta
