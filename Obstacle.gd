extends StaticBody3D

@export var sounds: Array[AudioStream] = []

var since_last = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	since_last += 1
	pass

func play_random_sound():
	if (sounds.size() > 0 && since_last > 30):
		since_last = 0
		var player = AudioStreamPlayer.new()
		player.stream = sounds.pick_random()
		player.autoplay = true
		player.bus = "Effects"
		add_child(player)
		await player.finished
		player.queue_free()
		
