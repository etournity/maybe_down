extends Camera3D

@export var npc : RigidBody3D

func _ready():
	pass

func _process(delta):
	position = position.lerp(npc.position + Vector3(0,0,15), delta)
