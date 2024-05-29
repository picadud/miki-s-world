extends Node


func _ready():
	var nodes = get_tree().get_nodes_in_group("button")
	for node in nodes:
		node.pressed.connect(_on_button_pressed)
		
func _on_button_pressed():
	$ButtonClick.play()
