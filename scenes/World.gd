extends Node3D

var npc : RigidBody3D 
var world: Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	npc = get_node("Node3D/NPC")
	world = get_node("World")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(Input.is_action_just_pressed("left")):
		world.global_transform = npc.global_transform * Transform3D().rotated(Vector3(0,0,1), 10 * delta)
	if(Input.is_action_just_pressed("right")):
		world.global_transform = npc.global_transform * Transform3D().rotated(Vector3(0,0,1), -10 *delta)
		
	world.position = Vector3(0,0,0)
	if(Input.is_action_just_pressed("quit")):
		get_tree().quit()
