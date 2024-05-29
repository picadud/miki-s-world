extends HSlider


func _ready():
	value_changed.connect(_on_value_changed)
	
func _on_value_changed(linear_value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(linear_value))
