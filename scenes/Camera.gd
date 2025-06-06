extends Camera3D

@export var npc : RigidBody3D
const CAM_OFFSET = Vector3(0,1,12)
func _ready():
	pass

func _process(delta):
	position = position.lerp(npc.position + CAM_OFFSET, delta * 5)

func reset_camera(): 
	position = npc.position + CAM_OFFSET
	rotation_degrees.z = 0
