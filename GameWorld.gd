extends Node2D

#https://github.com/picadud/miki-s-world.git

var level1 = preload("res://level/level_1.tscn")
var level2 = preload("res://level/level_2.tscn")
var level3 = preload("res://level/level_3.tscn")

var levelnum = 0

@onready var levels = [level1, level2, level3]


#初始生成
func _ready():
	new_level()

#重回出生点
func player_reset():
	$Player.position = $SpawnPoint.position

#连接关卡信号,把新生成的关卡的终点信号与new_level()连接
func connect_level_signal():
	var level_nodes = get_tree().get_nodes_in_group("level")
	for level_node in level_nodes:
		level_node.level_completed.connect(new_level)
		
		
#删掉旧关卡，生成新关卡
func new_level():
	var current_level = get_child(-1)
	if current_level.is_in_group("level"):
		current_level.level_completed.disconnect(new_level)
		current_level.queue_free()

	var level_gene = levels[levelnum].instantiate()
	add_child(level_gene)
	
	connect_level_signal()
	
	levelnum += 1
	player_reset()
