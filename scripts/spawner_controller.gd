extends Node2D

@onready var spawn_pos_left = $SpawnPosLeft
@onready var spawn_pos_right = $SpawnPosRight
@onready var timer = $Timer
@onready var spawn_boundary = %SpawnBoundary


const STONE_GREEN = preload("res://Scenes/stone_green.tscn")
const STONE_RED = preload("res://Scenes/stone_red.tscn")

var stone_array
var position_array

var random_spawning: bool = false
var wave_just_spawned: bool = false
var countdown = 5

@export var wave_array: Array[PackedScene]

func _ready():
	stone_array = [STONE_GREEN, STONE_RED]
	position_array = [spawn_pos_left.global_position, self.global_position, spawn_pos_right.global_position]
	spawn_wave()
	spawn_boundary.wave_ended.connect(on_wave_ended)
	
func _process(delta):
	pass

func spawn_wave():
	var wave_to_spawn = wave_array.pick_random().instantiate()
	self.add_child(wave_to_spawn)
	wave_to_spawn.global_position = self.global_position
	#var coin_toss = randi_range(0, 1)
	#
	#if coin_toss == 1:
		#random_spawning = true
	#if coin_toss == 0:
		#random_spawning = false
	
func spawn(stones_to_spawn):
	
	for i in stones_to_spawn:
		var stone_to_spawn = stone_array.pick_random().instantiate()
		self.add_child(stone_to_spawn)
		stone_to_spawn.position = position_array.pick_random()
		await get_tree().create_timer(0.3).timeout
	
	random_spawning = false
	
	#var random_time = randf_range(0.3, 0.7)
	#timer.wait_time = 0.3
	#timer.start()
	
func on_wave_ended():
	if random_spawning:
		spawn(5)
	elif random_spawning == false:
		spawn_wave()
		
	
func _on_timer_timeout():
	if StatesAndStuff.going_down:
		if random_spawning:
			spawn(5)
			countdown -= 1
			if countdown == 0:
				random_spawning = false
				countdown = 5
		if random_spawning == false:
			spawn_wave()
