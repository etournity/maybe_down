extends Control

var progress = []
var mainScene = "res://scenes/main.tscn"
var loadingStatus
# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceLoader.load_threaded_request(mainScene, "PackedScene", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	loadingStatus = ResourceLoader.load_threaded_get_status(mainScene, progress)
	print(progress)
	$ColorRect/CenterContainer/VBoxContainer/ProgressBar.value = progress[0]*100
	
	if(loadingStatus == 3):
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(mainScene))
	
