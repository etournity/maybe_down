extends Node3D

var npc : RigidBody3D 
var world: Node3D
var camera: Camera3D
var target_rot: float = 0.0
@export_range(1, 10) var snappiness: float = 1.0
@export_range(2, 20) var rotation_speed: float = 10

func _ready():
	npc = get_node("Node3D/NPC")
	world = get_node("World")
	camera = get_node("Camera")

func _process(delta):
	if(Input.is_action_just_pressed("left")):
		target_rot += rotation_speed
	if(Input.is_action_just_pressed("right")):
		target_rot -= rotation_speed
	
	var current_rot = camera.rotation_degrees.z
	var smooth_rot = current_rot + (target_rot - current_rot) * delta * snappiness
	camera.rotation_degrees.z = smooth_rot
	
	PhysicsServer3D.area_set_param(get_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY_VECTOR, -camera.basis.y * 1.7)

	if(Input.is_action_just_pressed("quit")):
		get_tree().quit()
