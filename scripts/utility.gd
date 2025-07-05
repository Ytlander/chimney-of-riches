extends Node

var print_wave_value: bool = true

func _ready():
	SignalBus.wave_spawned.connect(_on_wave_spawned)

func frameFreeze(slowness, duration):
	Engine.time_scale = slowness
	await get_tree().create_timer(duration * slowness).timeout
	Engine.time_scale = 1.0

func wave_value(wave):
	var accumulated_value: int = 0
	var stones = wave.get_children()
	for stone in stones:
		if stone.is_in_group("Stone"):
			accumulated_value += stone.value
	
	print(wave, " has ", accumulated_value, " value" )


func _on_wave_spawned(wave):
	if print_wave_value:
		wave_value(wave)
