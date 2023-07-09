extends RigidBody3D

@export var sounds: Array[NoiseResource] = []

func _process(delta):
	if (get_collision_mask_value(1) == false && linear_velocity.y < 0):
		set_collision_mask_value(1, true)
		set_transparency(1)

func _on_body_entered(body):
	if body.is_in_group("bed"):
		apply_force(Vector3(0, body.velocity, 0))
		set_collision_mask_value(1, false)
		set_transparency(0.2)
	if (body.get_collision_layer_value(1) && body.has_method('play_random_sound')):
		body.play_random_sound()

func set_transparency(value):
	var override = get_child(0).get_child(0).get_surface_override_material(0)
	override.albedo_color = Color(1,1,1,value)
	get_child(0).get_child(0).set_surface_override_material(0, override)
