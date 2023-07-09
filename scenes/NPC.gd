extends RigidBody3D

func _process(delta):
	if (get_collision_mask_value(1) == false && linear_velocity.y < 0):
		set_collision_mask_value(1, true)
		set_transparency(0)

func _on_body_entered(body):
	if body.is_in_group("bed"):
		apply_force(Vector3(0, body.velocity, 0))
		set_collision_mask_value(1, false)
		set_transparency(1)
		

func set_transparency(value):
	var override = get_child(0).get_child(0).get_surface_override_material(0)
	override.transparency = value
	get_child(0).get_child(0).set_surface_override_material(0, override)
