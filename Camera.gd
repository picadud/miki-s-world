extends Camera2D

@onready var player = get_node("../Player")

#相机跟随主角
func _process(_delta):
	position = player.global_position
