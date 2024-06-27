extends CanvasLayer

signal options_exit

@onready var master_volume_slider = $Control/PanelContainer/MarginContainer/VBoxContainer/TabContainer/Audio/MasterVolume
@onready var bgm_volume_slider = $Control/PanelContainer/MarginContainer/VBoxContainer/TabContainer/Audio/BGMVolume
@onready var sfx_volume_slider = $Control/PanelContainer/MarginContainer/VBoxContainer/TabContainer/Audio/SFXVolume

func load_settings():
	var audio_settings:Dictionary = ConfigFileHandler.load_audio_settings()
	var keybinds_settings:Dictionary = ConfigFileHandler.load_keybinds_settings()
	
	master_volume_slider.value = audio_settings.master_volume
	bgm_volume_slider.value = audio_settings.bgm_volume
	sfx_volume_slider.value = audio_settings.sfx_volume
	
	#下面创建了一个inputevent，为了将设置文件的keymap设置到当前游戏里。
	for key in keybinds_settings:
		print(keybinds_settings[key])
		var new_iptevent = InputEventKey.new()
		new_iptevent.keycode = keybinds_settings[key]
		InputMap.action_erase_events(key)
		InputMap.action_add_event(key, new_iptevent)

	get_tree().call_group("keybindbutton", "display_key")

func _ready():
	load_settings()
	
	$Control/PanelContainer/MarginContainer/VBoxContainer/TabContainer.set_tab_title(0, "音量设置")
	
	
#按下按钮退出菜单
func _on_button_pressed():
	emit_signal("options_exit")

#保存音量设置
func _on_master_volume_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_setting("master_volume", master_volume_slider.value)


func _on_bgm_volume_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_setting("bgm_volume", bgm_volume_slider.value)


func _on_sfx_volume_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_setting("sfx_volume", sfx_volume_slider.value)

#处理“回到主菜单”
func _on_back_2_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://gui/main_menu.tscn")

