extends Node

@onready var stone_destroy = $StoneDestroy
@onready var stone_pickup = $StonePickup
@onready var coin_pickup = $CoinPickup
@onready var shop_purchase = $ShopPurchase


func _ready():
	SignalBus.stone_destroy.connect(_on_stone_destroy)
	SignalBus.stone_pickup.connect(_on_stone_pickup)
	SignalBus.coin_pickup.connect(_on_coin_pickup)
	SignalBus.shop_purchase.connect(_on_shop_purchase)
	
func _on_stone_destroy(stone):
	stone_destroy.play()

func _on_stone_pickup(stone):
	stone_pickup.play()

func _on_coin_pickup(coin):
	coin_pickup.play()

func _on_shop_purchase():
	shop_purchase.play()
