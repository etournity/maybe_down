extends RigidBody3D

@export var sounds: Array[AudioStream] = []
@export var default_sounds: Array[AudioStream] = []
@export var main: Node3D

var since_last = 0
var rng = RandomNumberGenerator.new()

func _process(delta):
	since_last += 1
	if (get_collision_mask_value(1) == false && linear_velocity.y < 0):
		main.can_rotate = true
		set_collision_mask_value(1, true)
		set_transparency(1)

func _on_body_entered(body):
	if body.is_in_group("bed"):
		main.can_rotate = false
		apply_force(Vector3(0, body.velocity, 0))
		set_collision_mask_value(1, false)
		set_transparency(0.2)
	if (body.get_collision_layer_value(1) && body.has_method('play_random_sound')):
		if(rng.randf() > 0.05):
			body.play_random_sound()
		else:
			play_sound(sounds)
	else:
		play_sound(default_sounds)

func set_transparency(value):
	var override = get_child(0).get_child(0).get_surface_override_material(0)
	override.albedo_color = Color(1,1,1,value)
	get_child(0).get_child(0).set_surface_override_material(0, override)

func play_sound(sound_list):
	if (sound_list.size() > 0 && since_last > 30):
		since_last = 0
		var player = AudioStreamPlayer.new()
		player.stream = sound_list.pick_random()
		player.autoplay = true
		player.bus = "Effects"
		add_child(player)
		await player.finished
		player.queue_free()

