extends Node

@onready var timer = $Timer

@onready var start_round_button = %StartRoundButton
@onready var money = $Money
@onready var multiplier = $Multiplier

#Shop references
@onready var shop_button = $ShopButton
@onready var shop = $Shop
@onready var speed_upgrade_cost = $Shop/SpeedUpgradeCost
@onready var speed_upgrade_button = $Shop/SpeedUpgradeButton
@onready var area_upgrade_cost = $Shop/AreaUpgradeCost
@onready var area_upgrade_button = $Shop/AreaUpgradeButton
@onready var length_upgrade_cost = $Shop/LengthUpgradeCost
@onready var length_upgrade_button = $Shop/LengthUpgradeButton

#Shop variables
var speed_cost = 100
var area_cost = 250
var length_cost = 50

#Upgrade variables

#Game variables
@export var chimney_length:int = 30
@export var money_multiplier:float = 1.0
@export var money_multiplier_default:float = 1.0

signal round_start_signal
signal round_end_signal

func _ready():
	SignalBus.stone_pickup.connect(_on_stone_pickup)
	SignalBus.coin_pickup.connect(_on_coin_pickup)
	shop.visible = false
	start_round_button.visible = true
	multiplier.text = "X" + str(money_multiplier)

func _process(delta):
	pass

func _on_stone_pickup(stone):
	StatesAndStuff.money += stone.value * money_multiplier
	money.text = str(StatesAndStuff.money)

func _on_coin_pickup(multiplier_increase):
	money_multiplier += multiplier_increase
	multiplier.text = "X" + str(money_multiplier)
	
func _on_timer_timeout():
	if StatesAndStuff.going_down:
		StatesAndStuff.going_down = false
		SignalBus.going_up.emit()
		timer.start()
	
	elif StatesAndStuff.going_down == false:
		round_end_signal.emit()
		round_end()

func round_start():
	shop_button.visible = false
	StatesAndStuff.going_down = true
	round_start_signal.emit()
	chimney_length = StatesAndStuff.chimney_length
	timer.wait_time = chimney_length
	timer.start()

func round_end():
	shop_button.visible = true
	start_round_button.visible = true
	money_multiplier = money_multiplier_default
	multiplier.text = "X" + str(money_multiplier)

func _on_start_round_button_pressed():
	round_start()
	start_round_button.visible = false
	
#region shop
func shop_update():
	speed_upgrade_cost.text = str(speed_cost)
	if StatesAndStuff.boundary_bottom_position < StatesAndStuff.boundary_bottom_max:
		area_upgrade_cost.text = str(area_cost)
	if StatesAndStuff.chimney_length < StatesAndStuff.chimney_length_max:
		length_upgrade_cost.text = str(length_cost)

func _on_shop_button_pressed():
	shop_update()
	shop.visible = true
	start_round_button.visible = false

func _on_exit_shop_button_pressed():
	shop.visible = false
	start_round_button.visible = true

func _on_speed_upgrade_button_pressed():
	if StatesAndStuff.money >= speed_cost:
		StatesAndStuff.change_player_speed(10)
		deduct_money(speed_cost)
		speed_cost += 50
		shop_update()
		SignalBus.shop_purchase.emit()

func _on_area_upgrade_button_pressed():
	if StatesAndStuff.money >= area_cost:
		StatesAndStuff.change_boundary_bottom(10)
		deduct_money(area_cost)
		area_cost += 100
		shop_update()
		SignalBus.shop_purchase.emit()
		if StatesAndStuff.boundary_bottom_position.y >= StatesAndStuff.boundary_bottom_max.y:
			area_upgrade_cost.text = "MAX!"
			area_upgrade_button.visible = false

func _on_length_upgrade_button_pressed():
	if StatesAndStuff.money >= length_cost:
		StatesAndStuff.chimney_length += 10
		deduct_money(length_cost)
		length_cost += 10
		shop_update()
		SignalBus.shop_purchase.emit()
		if StatesAndStuff.chimney_length >= StatesAndStuff.chimney_length_max:
			length_upgrade_cost.text = "Max!"
			length_upgrade_button.visible = false

func deduct_money(amount):
	StatesAndStuff.money -= amount
	money.text = str(StatesAndStuff.money)

#endregion

func _on_cheat_button_pressed():
	StatesAndStuff.money += 1000
	deduct_money(0)
