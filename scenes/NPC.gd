extends RigidBody3D

func _process(delta):
	if (get_collision_mask_value(1) == false && linear_velocity.y < 0):
		set_collision_mask_value(1, true)

func _on_body_entered(body):
	if body.is_in_group("bed"):
		apply_force(Vector3(0, body.velocity, 0))
		set_collision_mask_value(1, false)

