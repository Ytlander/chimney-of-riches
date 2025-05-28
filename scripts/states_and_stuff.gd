extends Node

#General game Variables
var going_down = true
var money: int = 0:
	set(value):
		money = value
		SignalBus.money_changed.emit()
var speed = 500



#Upgrade related variables
@export var player_speed: int
@export var player_speed_max: int = 180
@export var boundary_bottom_position: Vector2 #Max: Vector2(-1, 42) 
var boundary_bottom_max: Vector2 = Vector2(-1, 50)
@export var chimney_length: int = 10 #Default 10, max 60
@export var chimney_length_max: int = 60

func change_boundary_bottom(new_y_position):
	boundary_bottom_position.y += new_y_position
	SignalBus.boundary_bottom_change.emit()
	
func change_player_speed(speed_increase):
	player_speed += speed_increase
	SignalBus.player_speed_change.emit()
