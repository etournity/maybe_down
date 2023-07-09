extends Control

var music_player: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	music_player = $MenuMusic  # Assign the reference to the existing "Menu Music" AudioStreamPlayer node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_pressed():
	music_player.stop()  # Stop the playback of the "Menu Music" AudioStreamPlayer
	hide()
	Global.start_game()
	

func _on_options_pressed():
	$Container.hide()
	$options.open()

func _on_exit_pressed():
	get_tree().quit() 

func _on_options_back():
	$options.close()
	$Container.show()
