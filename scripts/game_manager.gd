extends Node

@onready var timer = $Timer
@export var chimney_length:int = 30
@onready var start_round_button = %StartRoundButton
@onready var money = $Money
#Shop references
@onready var shop_button = $ShopButton
@onready var shop = $Shop
@onready var speed_upgrade_cost = $Shop/SpeedUpgradeCost
@onready var area_upgrade_cost = $Shop/AreaUpgradeCost
@onready var area_upgrade_button = $Shop/AreaUpgradeButton

#Shop variables
var speed_cost = 100
var area_cost = 250


signal round_start_signal
signal round_end_signal

func _ready():
	SignalBus.stone_pickup.connect(_on_stone_pickup)
	shop.visible = false
	start_round_button.visible = true

func _process(delta):
	pass

func _on_stone_pickup(stone):
	StatesAndStuff.money += stone.value
	money.text = str(StatesAndStuff.money)

func _on_timer_timeout():
	if StatesAndStuff.going_down:
		StatesAndStuff.going_down = false
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

func _on_start_round_button_pressed():
	round_start()
	start_round_button.visible = false
	
#region shop
func shop_update():
	speed_upgrade_cost.text = str(speed_cost)
	area_upgrade_cost.text = str(area_cost)

func _on_shop_button_pressed():
	shop_update()
	shop.visible = true
	start_round_button.visible = false

func _on_exit_shop_button_pressed():
	shop.visible = false
	start_round_button.visible = true

func _on_speed_upgrade_button_pressed():
	if StatesAndStuff.money >= speed_cost:
		StatesAndStuff.player_speed += 10
		deduct_money(speed_cost)
		speed_cost += 50
		shop_update()

func _on_area_upgrade_button_pressed():
	if StatesAndStuff.money >= area_cost:
		StatesAndStuff.change_boundary_bottom(10)
		deduct_money(area_cost)
		area_cost += 100
		shop_update()
		if StatesAndStuff.boundary_bottom_position.y >= StatesAndStuff.boundary_bottom_max.y:
			area_upgrade_cost.text = "MAX!"
			area_upgrade_button.visible = false

func deduct_money(amount):
	StatesAndStuff.money -= amount
	money.text = str(StatesAndStuff.money)

#endregion

func _on_cheat_button_pressed():
	StatesAndStuff.money += 1000
	deduct_money(0)
