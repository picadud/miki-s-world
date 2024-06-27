extends Button

@export var action:String = "jump"

func _ready():
	set_process_unhandled_key_input(false)
	toggle_mode = true
	add_to_group("keybindbutton")

func display_key():
	text = "%s" % InputMap.action_get_events(action)[0].as_text()

func _on_toggled(toggled_on):
	set_process_unhandled_key_input(toggled_on)
	if button_pressed:
		text = "waiting......"
	else:
		display_key()

func _unhandled_key_input(event):
	remap_key(event)
	
	var keycode = event.keycode
	print(keycode)
	ConfigFileHandler.save_keybinds_setting(action, keycode)
	
	button_pressed = false
	
func remap_key(event):
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)
	
	text = "%s" % event.as_text()
