extends Control

signal back
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open():
	show()

func close():
	hide()
	
func handle_volume_change(bus_idx,volume):
	#Change this if you have changed the slider "Min Value"
	if(volume == -50):
		AudioServer.set_bus_mute(bus_idx,true)
	else: AudioServer.set_bus_mute(bus_idx,false)
	AudioServer.set_bus_volume_db(bus_idx,volume)


func _on_button_pressed():
	back.emit()


func _on_master_slider_value_changed(value):
		handle_volume_change(AudioServer.get_bus_index("Master"),value)


func _on_music_slider_value_changed(value):
		handle_volume_change(AudioServer.get_bus_index("Music"),value)


func _on_effects_slider_value_changed(value):
		handle_volume_change(AudioServer.get_bus_index("Effects"),value)

func _on_check_button_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
