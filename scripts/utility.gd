extends Node

func frameFreeze(slowness, duration):
	Engine.time_scale = slowness
	await get_tree().create_timer(duration * slowness).timeout
	Engine.time_scale = 1.0
