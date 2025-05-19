extends Node

#General game Variables
var going_down = true
var money: int = 0
var speed = 500

#Upgrade related variables
@export var player_speed: int
@export var boundary_bottom_position: Vector2 #Max: Vector2(-1, 42) 
@export var chimney_length: int = 10 #Default 10, max 60

func change_boundary_bottom(new_position):
	boundary_bottom_position = new_position
	SignalBus.boundary_bottom_change.emit()
	
func change_player_speed(new_speed):
	player_speed = new_speed
	SignalBus.player_speed_change.emit()
