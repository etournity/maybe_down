extends MarginContainer
class_name LeaderboardItem

@onready var placeLabel: Label = %Place
@onready var usernameLabel: Label = %Username
@onready var timeLabel: Label = %Time

var data: Dictionary

func _ready():
	placeLabel.text = "%s." % data.place
	usernameLabel.text = data.username
	var formattedTime = "Time: %02d:%02d.%03d" % [data.time/60,fmod(data.time,60), fmod(data.time,1)*1000]
	timeLabel.text = formattedTime

func set_data(place:String,username:String,time:float):
	data = {
		"place": place,
		"username": username,
		"time": time
		}
