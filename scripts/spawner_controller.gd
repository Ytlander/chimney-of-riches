extends Node2D

@onready var spawn_pos_left = $SpawnPosLeft
@onready var spawn_pos_right = $SpawnPosRight
@onready var timer = $Timer
@onready var spawn_boundary = %SpawnBoundary
@onready var stones = $Stones


const STONE_GREEN = preload("res://Scenes/stone_green.tscn")
const STONE_RED = preload("res://Scenes/stone_red.tscn")

var stone_array
var position_array
var instantiated_stones: Array

var random_spawning: bool = false
var wave_just_spawned: bool = false
var no_spawn: bool = true
var countdown = 5

@export var wave_array: Array[PackedScene]

func _ready():
	stone_array = [STONE_GREEN, STONE_RED]
	position_array = [spawn_pos_left.global_position, self.global_position, spawn_pos_right.global_position]
	spawn_boundary.wave_ended.connect(on_wave_ended)
	
func _process(delta):
	pass

func spawn_wave():
	var wave_to_spawn = wave_array.pick_random().instantiate()
	stones.add_child(wave_to_spawn)
	wave_to_spawn.global_position = self.global_position
	var coin_toss = randi_range(0, 1)
	
	#Change Random spawning to true for one of the tosses for some random spawned stones
	if coin_toss == 1:
		random_spawning = false
	if coin_toss == 0:
		random_spawning = false
	
func spawn(number_to_spawn):
	for i in number_to_spawn:
		var stone_to_spawn = stone_array.pick_random().instantiate()
		stones.add_child(stone_to_spawn)
		stone_to_spawn.position = position_array.pick_random()
		if i == number_to_spawn -1:
			stone_to_spawn.last_in_wave = true
		await get_tree().create_timer(0.3).timeout
	
	random_spawning = false
	
func on_wave_ended():
	if no_spawn == true:
		pass
	elif random_spawning:
		spawn(5)
	elif random_spawning == false:
		spawn_wave()
		
func _on_game_manager_round_start_signal():
	spawn_wave()
	no_spawn = false

func _on_game_manager_round_end_signal():
	no_spawn = true
	instantiated_stones = stones.get_children()
	for stone in instantiated_stones:
		stone.queue_free()
	
