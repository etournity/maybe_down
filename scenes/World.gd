extends Node3D

var npc : RigidBody3D 
var world: Node3D
var camera: Camera3D
var click_sound: AudioStreamPlayer
@onready var music: AudioStreamPlayer = $Music
var target_rot: float = 0.0
@export_range(1, 10) var snappiness: float = 1.0
@export_range(2, 20) var rotation_speed: float = 10


func _ready():
	npc = $NPC
	world = $World
	camera = $Camera
	click_sound = $World/Click
	
	
func _process(delta):
	if(!$pause_menu.isOpen && Global.isStarted):
		get_rotated(delta)
	
	if(Input.is_action_just_pressed("quit")):
		get_tree().quit()
	
	if(Input.is_action_just_pressed("pause")):
		if($pause_menu.isOpen):
			$pause_menu.close()
		else:
			$pause_menu.open()
		toggle_time($pause_menu.isOpen)
	
func toggle_time(isPaused: bool):
	if(isPaused):
		Engine.time_scale = 0
	else:
		Engine.time_scale = 1

func get_rotated(delta):
	if(Input.is_action_just_pressed("left")):
		click_sound.play()
		target_rot += rotation_speed
	if(Input.is_action_just_pressed("right")):
		click_sound.play()
		target_rot -= rotation_speed
	
	var current_rot = camera.rotation_degrees.z
	var smooth_rot = current_rot + (target_rot - current_rot) * delta * snappiness
	camera.rotation_degrees.z = smooth_rot
	
	PhysicsServer3D.area_set_param(get_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY_VECTOR, -camera.basis.y * 1.7)

func start_music():
	music.play()

func _on_pause_menu_resume():
	$pause_menu.close()
	toggle_time(false)
