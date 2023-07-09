extends StaticBody3D

@export_range(0, 5000) var velocity = 3000.0: set = _set_state, get = _get_state
@export var sounds: Array[AudioStream] = []

func _get_state():
	return velocity

func _set_state(new_velocity):
	velocity = new_velocity

var since_last = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
		
