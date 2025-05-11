extends Node

signal wave_ended

func _on_area_exited(area):
	print(area)
	if area.last_in_wave:
		wave_ended.emit()
