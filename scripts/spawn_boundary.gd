extends Node

signal wave_ended

func _on_area_exited(area):
	if area.is_in_group("Stone"):
		if area.last_in_wave:
			wave_ended.emit()
