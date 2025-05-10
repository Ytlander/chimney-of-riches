extends Node2D

@onready var spawn_pos_left = $SpawnPosLeft
@onready var spawn_pos_right = $SpawnPosRight
@onready var timer = $Timer

const STONE_GREEN = preload("res://Scenes/stone_green.tscn")
const STONE_RED = preload("res://Scenes/stone_red.tscn")

var stone_array
var position_array

func _ready():
	stone_array = [STONE_GREEN, STONE_RED]
	position_array = [spawn_pos_left.global_position, self.global_position, spawn_pos_right.global_position]
	spawn()

func _process(delta):
	pass
	
func spawn():
	print("Spawning")
	var stone_to_spawn = stone_array.pick_random().instantiate()
	self.add_child(stone_to_spawn)
	stone_to_spawn.position = position_array.pick_random()
	var random_time = randf_range(0.3, 0.7)
	timer.wait_time = random_time
	timer.start()
	
func _on_timer_timeout():
	if StatesAndStuff.going_down:
		spawn()
