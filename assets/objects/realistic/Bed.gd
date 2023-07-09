extends StaticBody3D

@export_range(0, 5000) var velocity = 3000.0: set = _set_state, get = _get_state

func _get_state():
	return velocity

func _set_state(new_velocity):
	velocity = new_velocity
