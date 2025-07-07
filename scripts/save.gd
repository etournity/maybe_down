extends Node
#Global Save

signal new_entry

func save_time(name:String,time:float):
	var read = FileAccess.open("user://save_game.dat", FileAccess.READ)
	var old = JSON.parse_string(read.get_line())
	read.close()
	var new:Dictionary = {
		"name": name,
		"time": time
	}
	var data: Array[Dictionary] = [new]
	if(old): 
		data.append_array(old)
	var json = JSON.stringify(data)
	var write = FileAccess.open("user://save_game.dat", FileAccess.WRITE)

	write.store_line(json)
	write.close()
	new_entry.emit()



func read_times()-> Array:
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	if (!file): return []
	var json_string = file.get_line()
	if (json_string.length() < 1):
		return []
	var data = JSON.parse_string(json_string)
	print(data)
	return data
