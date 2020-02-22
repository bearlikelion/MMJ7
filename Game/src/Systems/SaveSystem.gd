extends Node

var game_save = {}
var game_save_path : String = "save/"
var testVar

func _ready():
	pass 
	
func save(savefile):
	room.saveRoom(room.roomPrevious)
	var file = File.new()
	#save_game.open("user://" + game_save_path + "Save_" + str(savefile) + ".save", File.WRITE)
	var saveName = "Save_" + str(savefile)
	file.open("user://" + saveName + ".dat", File.WRITE)
	var saveData = {}
	saveData["playerData"] = {
		"Room": room.roomPrevious,
	}
	saveData["roomState"] = room.roomState
	file.store_line(to_json(saveData))
	file.close()
	
func load(savefile):
	var file = File.new()
	var saveName = "Save_" + str(savefile)
	if file.file_exists("user://" + saveName + ".dat") == true:
		file.open("user://" + saveName + ".dat", File.READ)
	var content = file.get_as_text()
	var roomToLoad
	
	while not file.eof_reached():
		var current_line = parse_json(file.get_line())
		
		if current_line == null:
			continue
		testVar = current_line
		room.roomState = current_line.roomState
		roomToLoad = current_line.playerData.Room
	room.loadRoomNoSave(roomToLoad)
	file.close()
