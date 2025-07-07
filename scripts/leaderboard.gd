extends Control

@onready var local: VBoxContainer = %LocalList
const LEADERBOARD_ITEM = preload("res://scenes/UI/leaderboard_item.tscn")
func _ready() -> void:
	
	Save.new_entry.connect(on_new_entry)
	load_entries()

func on_new_entry():
	load_entries()

func load_entries():
	var data = Save.read_times()
	if (data.size() < 1): 
		pass
	for child in local.get_children():
		child.queue_free()
	#sort by time ascending so we can loop through items in order
	data.sort_custom(func (a,b): return a.time < b.time )
	for i in data.slice(0,5).size():
		var item = data[i]
		if item.has("time") && item.has("name"):
			var entry:LeaderboardItem = LEADERBOARD_ITEM.instantiate()
			entry.set_data(str(i + 1),item.name,item.time)
			local.add_child(entry)
