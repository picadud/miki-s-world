extends Node

#config file handler，save and load settings

var config = ConfigFile.new()

const CONFIG_FILE_PATH = "user://config.cfg"

func _ready():
	config.load(CONFIG_FILE_PATH)
	if !config.has_section("audio"):
		config_init()
		print("初始化了声音设置")
		
		
func config_init():
	var dict = {
		"master_volume":0.8,
		"bgm_volume":0.8,
		"sfx_volume":0.8
	}
	
	for key in dict.keys():
		config.set_value("audio", key, dict[key])
		
	config.save(CONFIG_FILE_PATH)


func save_audio_setting(key:String, value):
	config.set_value("audio", key, value)
	config.save(CONFIG_FILE_PATH)
	
	
func load_audio_settings():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings
