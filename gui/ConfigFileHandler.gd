extends Node

#config file handler，save and load settings

var config = ConfigFile.new()

const CONFIG_FILE_PATH = "user://config.cfg"

func _ready():
	config.load(CONFIG_FILE_PATH)
	if !config.has_section("audio") or !config.has_section("keybinds"):
		config_init()
		print("init settings")
		
		
func config_init():
	var dict_volume = {
		"master_volume":0.8,
		"bgm_volume":0.8,
		"sfx_volume":0.8
	}
	
	var dict_keybinds = {
		"jump":4194320,
		"move_left":4194319,
		"move_right":4194321
	}
	
	for key in dict_volume.keys():
		config.set_value("audio", key, dict_volume[key])
	
	for key in dict_keybinds.keys():
		config.set_value("keybinds", key, dict_keybinds[key])
		
	config.save(CONFIG_FILE_PATH)


func save_audio_setting(key:String, value):
	config.set_value("audio", key, value)
	config.save(CONFIG_FILE_PATH)
	
	
func load_audio_settings():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings

func save_keybinds_setting(key:String, value):
	config.set_value("keybinds", key, value)
	config.save(CONFIG_FILE_PATH)
	
func load_keybinds_settings():
	var keybinds_settings = {}
	for key in config.get_section_keys("keybinds"):
		keybinds_settings[key] = config.get_value("keybinds", key)
	return keybinds_settings
