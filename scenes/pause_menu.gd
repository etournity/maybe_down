extends Control

var isOpen: bool

signal resume
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	isOpen = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open():
	isOpen = true
	show()

func close():
	isOpen = false
	hide()

func _on_options_pressed():
	$VBoxContainer.hide()
	$options.open()



func _on_options_back():
	$options.close()
	$VBoxContainer.show()


func _on_resume_pressed():
	resume.emit()


func _on_quit_pressed():
	get_tree().quit()
