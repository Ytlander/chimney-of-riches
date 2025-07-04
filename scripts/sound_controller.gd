extends Node

@onready var stone_destroy = $StoneDestroy
@onready var stone_pickup = $StonePickup
@onready var coin_pickup = $CoinPickup
@onready var shop_purchase = $ShopPurchase


@onready var gameplay_music = $GameplayMusic
@onready var menu_music = $MenuMusic

const MUTE_DB:int = -80 
const DEFAULT_MUSIC_DB:float = 0.0
@export var fade_time: float = 2.0

var current_music_player: AudioStreamPlayer

#Store the position of each music track in this dictionary
var music_positions: Dictionary = {}


func _ready():
	SignalBus.stone_destroy.connect(_on_stone_destroy)
	SignalBus.stone_pickup.connect(_on_stone_pickup)
	SignalBus.coin_pickup.connect(_on_coin_pickup)
	SignalBus.shop_purchase.connect(_on_shop_purchase)
	
	current_music_player = menu_music
	current_music_player.play()
	
##Sound Effects	
func _on_stone_destroy(stone):
	stone_destroy.play()

func _on_stone_pickup(stone):
	stone_pickup.play()

func _on_coin_pickup(coin):
	coin_pickup.play()

func _on_shop_purchase():
	shop_purchase.play()
	
##Music
func fade_in_music(track: AudioStream):
	current_music_player.stream = track
	current_music_player.volume_db = MUTE_DB
	
	#Checking if we have stored a position and continues from there
	if music_positions.has(track):
		current_music_player.play(music_positions[track])
	else:
		current_music_player.play()
	
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(current_music_player, "volume_db", DEFAULT_MUSIC_DB, fade_time)

func fade_out_music():
	#Storing the current position when the music fades out, using the stream itself as key.
	if current_music_player.stream:
		music_positions[current_music_player.stream] = current_music_player.get_playback_position()
	
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	tween.tween_property(current_music_player, "volume_db", MUTE_DB, fade_time)

func crossfade_music_to(track: AudioStream):
	fade_out_music()
	
	if current_music_player == menu_music:
		current_music_player = gameplay_music
	else:
		current_music_player = menu_music
	
	fade_in_music(track)	

func _on_game_manager_round_start_signal():
	crossfade_music_to(gameplay_music.stream)

func _on_game_manager_round_end_signal():
	crossfade_music_to(menu_music.stream)
