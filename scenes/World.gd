extends Node3D

var npc : RigidBody3D 
var world: Node3D
var camera: Camera3D
var gravity: Vector3 = Vector3(0,-1,0)

func _ready():
	npc = get_node("Node3D/NPC")
	world = get_node("World")
	camera = get_node("Camera")

func _process(_delta):
	if(Input.is_action_just_pressed("left")):
		gravity += Vector3(0.1,0,0)
		camera.rotate_z(0.01)
	if(Input.is_action_just_pressed("right")):
		gravity += Vector3(-0.1,0,0)
		camera.rotate_z(-0.01)
	PhysicsServer3D.area_set_param(get_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY_VECTOR, gravity)


	if(Input.is_action_just_pressed("quit")):
		get_tree().quit()
