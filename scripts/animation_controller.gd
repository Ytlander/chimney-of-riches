extends Node

func _ready():
	SignalBus.stone_destroy.connect(_on_stone_destroy)
	

func _on_stone_destroy(stone):
	stone.animated_sprite.play("Explosion")
