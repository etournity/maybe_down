extends Node3D

@onready var npc : RigidBody3D = $NPC
@onready var world: Node3D = $World
@onready var camera: Camera3D = $Camera
@onready var click_sound: AudioStreamPlayer = $World/Click
@onready var music: AudioStreamPlayer = $Music
@onready var pauseMenu: Control = $pause_menu
@onready var timer: RichTextLabel = $UI/Timer
@onready var finalTime: Label = $"UI/Game Over/VBoxContainer/Time"
@onready var gameOver: CenterContainer = $"UI/Game Over"
var target_rot: float = 0.0
@export_range(1, 10) var snappiness: float = 1.0
@export_range(2, 20) var rotation_speed: float = 10
var can_rotate = true


func _ready():
	npc.freeze = true

func _process(delta):
	if(!Global.gameState == Global.GameStates.RUNNING):
		return
		
	if(!pauseMenu.isOpen):
		if (can_rotate):
			get_rotated(delta)
	
func toggle_pause(isPaused: bool):
	if(isPaused):
		get_tree().paused = true
	else:
		get_tree().paused = false

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


func set_timer_time(time: String):
	timer.text = time
	
func _on_pause_menu_resume():
	pauseMenu.close()
	toggle_pause(false)
