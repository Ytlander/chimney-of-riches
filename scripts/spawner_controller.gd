extends Node2D

@onready var spawn_pos_left = $SpawnPosLeft
@onready var spawn_pos_right = $SpawnPosRight
@onready var timer = $Timer
@onready var wave_cooldown = $WaveCooldown

const STONE_GREEN = preload("res://Scenes/stone_green.tscn")
const STONE_RED = preload("res://Scenes/stone_red.tscn")

var stone_array
var position_array

var random_spawning: bool = true
var wave_just_spawned: bool = false
var countdown = 5

@export var wave_array: Array[PackedScene]

func _ready():
	stone_array = [STONE_GREEN, STONE_RED]
	position_array = [spawn_pos_left.global_position, self.global_position, spawn_pos_right.global_position]
	spawn()

func _process(delta):
	pass

func spawn_wave():
	var wave_to_spawn = wave_array.pick_random().instantiate()
	self.add_child(wave_to_spawn)
	wave_to_spawn.global_position = self.global_position
	wave_to_spawn.global_position.y += 400 #400 distance is enough for 6 waves of random spawns on 0.3 sec cooldown
	timer.wait_time = 2
	timer.start()
	
func spawn():
	print("Spawning")
	var stone_to_spawn = stone_array.pick_random().instantiate()
	self.add_child(stone_to_spawn)
	stone_to_spawn.position = position_array.pick_random()
	var random_time = randf_range(0.3, 0.7)
	timer.wait_time = 0.3
	timer.start()
	
func _on_timer_timeout():
	if StatesAndStuff.going_down:
		if random_spawning:
			spawn()
			countdown -= 1
			if countdown == 0:
				random_spawning = false
				countdown = 2
				print("Random Spawning is: ", random_spawning, "Countdown is: ", countdown)
		if random_spawning == false:
			spawn_wave()
			countdown -= 1
			if countdown == 0:
				random_spawning = true
				countdown = 5
				print(random_spawning, countdown)
