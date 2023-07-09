extends Control

var isOpen: bool
@onready var options: Control = $options
@onready var rootMenu: VBoxContainer = $RootMenu
signal resume
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	isOpen = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open():
	Global.set_music_filter(true)
	isOpen = true
	show()

func close():
	if(options.is_visible_in_tree()):
		options.close()
		rootMenu.show()
	else:
		Global.set_music_filter(false)
		isOpen = false
		hide()
	


func _on_options_pressed():
	rootMenu.hide()
	options.open()



func _on_options_back():
	options.close()
	rootMenu.show()


func _on_resume_pressed():
	resume.emit()


func _on_quit_pressed():
	get_tree().quit()
