extends Control

var progress = []
@onready var mainScene = preload("res://scenes/main.tscn")
var loadingStatus
# Called when the node enters the scene tree for the first time.
func _ready():
		get_tree().change_scene_to_packed(mainScene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
