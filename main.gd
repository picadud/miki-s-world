extends Node2D

var pause_value = false

#
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$GameWorld.process_mode = Node.PROCESS_MODE_PAUSABLE
	$SoundControl.process_mode = Node.PROCESS_MODE_ALWAYS
	$OptionsMenu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	$OptionsMenu.hide()

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
		
#暂停菜单
func pause_game():
	if pause_value == false:
		get_tree().paused = true
		$OptionsMenu.show()
		pause_value = true
	else:
		get_tree().paused = false
		$OptionsMenu.hide()
		pause_value = false
	
#退出菜单
func _on_options_menu_options_exit():
	pause_game()
