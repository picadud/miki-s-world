extends CanvasLayer


func _ready():
	$OptionsMenu.hide()

func _on_play_pressed():
	await $SoundControlGUI/ButtonClick.finished
	get_tree().change_scene_to_file("res://main.tscn")


#退出游戏
func _on_exit_pressed():
	get_tree().quit()

#进入菜单
func _on_options_pressed():
	$Title.hide()
	$Buttons.hide()
	$OptionsMenu.show()

#回到主界面
func _on_options_menu_options_exit():
	$Title.show()
	$Buttons.show()
	$OptionsMenu.hide()
