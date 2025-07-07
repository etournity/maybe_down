extends Camera3D

@export var npc : RigidBody3D
const CAM_OFFSET = Vector3(0,1,12)
const DIFF_MOD = 0.05
func _ready():
	pass

func _physics_process(delta):
	var diff: float = position.distance_squared_to(npc.position)
	position = position.lerp(npc.position + CAM_OFFSET,delta * (diff - 50) * DIFF_MOD )

func reset_camera(): 
	position = npc.position + CAM_OFFSET
	rotation_degrees.z = 0
