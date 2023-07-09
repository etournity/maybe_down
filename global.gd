extends Node

enum GameStates {
	MAIN_MENU = 0,
	RUNNING = 1,
	FINISHED = 2,
}

var gameState:GameStates = 0

var time = 0
var formattedTime = "00:00:000"

@onready var mainTheme: AudioStreamOggVorbis = load("res://audio/main_theme_loop.ogg")
@onready var menuTheme: AudioStreamOggVorbis = load("res://audio/menu_music_loop.ogg")
@onready var musicNode: AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	init_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(gameState == GameStates.RUNNING):
		time += delta
		formattedTime = "Time: %02d:%02d:%03d" % [time/60,fmod(time,60), fmod(time,1)*1000]
	Main.set_timer_time(formattedTime)
	
	if(Input.is_action_just_pressed("quit")):
		get_tree().quit()
	
	if(Input.is_action_just_pressed("pause")):
		if(Main.pauseMenu.isOpen):
			Main.pauseMenu.close()
			
		else:
			Main.pauseMenu.open()
		Main.toggle_pause(Main.pauseMenu.isOpen)

func start_game():
	gameState = GameStates.RUNNING
	Main.npc.freeze = false
	play_main_theme()
	

func finish_game():
	gameState = GameStates.FINISHED

func init_music():
	musicNode = AudioStreamPlayer.new()
	musicNode.bus = "Music"
	add_child(musicNode)
	play_menu_theme()

func play_menu_theme():

	musicNode.stop()
	AudioServer.set_bus_bypass_effects(AudioServer.get_bus_index("Music"),false)
	musicNode.stream = menuTheme
	musicNode.volume_db = -15
	musicNode.play()

func play_main_theme():
	musicNode.stop()
	AudioServer.set_bus_bypass_effects(AudioServer.get_bus_index("Music"),true)
	musicNode.stream = mainTheme
	musicNode.volume_db = -10
	musicNode.play()
