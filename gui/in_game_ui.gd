extends CanvasLayer

@onready var life_counter = $VBoxContainer/LifeCounter.get_children()
@onready var coin_number = $VBoxContainer/HBoxContainer/Label


func update_life(value):
	for item in 10:
		life_counter[item].visible = value > item

func update_coin(value):
	print("update coin")
	print(value) 
	coin_number.text = " X %s" %value


func _on_player_life_changed(value):
	update_life(value)


func _on_player_coin_changed(value):
	update_coin(value)
