extends CanvasLayer

signal options_exit

@onready var master_volume_slider = $Control/PanelContainer/VBoxContainer/TabContainer/Audio/MasterVolume
@onready var bgm_volume_slider = $Control/PanelContainer/VBoxContainer/TabContainer/Audio/BGMVolume
@onready var sfx_volume_slider = $Control/PanelContainer/VBoxContainer/TabContainer/Audio/SFXVolume


func _ready():
	var audio_settings:Dictionary = ConfigFileHandler.load_audio_settings()
	master_volume_slider.value = audio_settings.master_volume
	bgm_volume_slider.value = audio_settings.bgm_volume
	sfx_volume_slider.value = audio_settings.sfx_volume
	
	
#按下按钮退出菜单
func _on_button_pressed():
	emit_signal("options_exit")


func _on_master_volume_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_setting("master_volume", master_volume_slider.value)


func _on_bgm_volume_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_setting("bgm_volume", bgm_volume_slider.value)


func _on_sfx_volume_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_setting("sfx_volume", sfx_volume_slider.value)
