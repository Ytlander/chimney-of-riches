extends StaticBody2D

func _ready():
	self.position = StatesAndStuff.boundary_bottom_position
	SignalBus.boundary_bottom_change.connect(_on_boundary_bottom_change)
	
func _on_boundary_bottom_change():
	self.position = StatesAndStuff.boundary_bottom_position
