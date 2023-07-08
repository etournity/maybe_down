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

func _on_button_pressed():
	back.emit()
