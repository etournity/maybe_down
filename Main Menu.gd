extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
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
