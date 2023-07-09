extends Node

enum GameStates {
	MAIN_MENU = 0,
	RUNNING = 1,
	FINISHED = 2,
}

var gameState:GameStates = 0

var time = 0
var formattedTime = "00:00:000"
# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(gameState == GameStates.RUNNING):
		time += delta
	Main.set_timer_time("Time: %02d:%02d:%03d" % [time/60,fmod(time,60), fmod(time,1)*1000])
	
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
	Main.start_music()

func finish_game():
	gameState = GameStates.FINISHED
	Main.stop_music()
