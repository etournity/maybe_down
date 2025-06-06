extends Node

enum GameStates {
	MAIN_MENU = 0,
	RUNNING = 1,
	FINISHED = 2,
}

var gameState:GameStates = GameStates.MAIN_MENU

var time = 0
var formattedTime = "Time: 00:00:000"

@onready var mainTheme: AudioStreamOggVorbis = load("res://audio/main_theme_loop.ogg")
@onready var menuTheme: AudioStreamOggVorbis = load("res://audio/menu_music_loop.ogg")
@onready var musicNode: AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	reset_timer()
	init_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(gameState == GameStates.RUNNING):
		increment_timer(delta)
		if(Input.is_action_just_pressed("pause")):
			if(Main.pauseMenu.isOpen):
				Main.pauseMenu.close()
				if(Global.gameState == Global.GameStates.FINISHED):
					Main.gameOver.show()
			else:
				if(Global.gameState == Global.GameStates.FINISHED):
					Main.gameOver.hide()
				Main.pauseMenu.open()
			Main.set_pause(Main.pauseMenu.isOpen)
			
	if(Input.is_action_just_pressed("quit")):
		quit()

func start_game():
	gameState = GameStates.RUNNING
	Main.npc.freeze = false
	play_main_theme()
	

func finish_game():
	gameState = GameStates.FINISHED
	Main.finalTime.text = formattedTime
	Main.gameOver.show()

func restart_game():
	Main.gameOver.hide()
	Main.reset_player()
	reset_timer()
	gameState = GameStates.RUNNING
	play_main_theme()

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

func set_music_filter(enable: bool):
	AudioServer.set_bus_bypass_effects(AudioServer.get_bus_index("Music"),!enable)

func reset_timer():
	time = 0
	formattedTime = "Time: 00:00:000"
	# Main.set_timer_time(formattedTime)

func increment_timer(delta):
	time += delta
	formattedTime = "Time: %02d:%02d:%03d" % [time/60,fmod(time,60), fmod(time,1)*1000]
	Main.set_timer_time(formattedTime)

func quit():
	get_tree().quit()
