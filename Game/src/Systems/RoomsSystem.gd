extends Node

export var roomState = {}
export var roomPrevious = ""
export var roomPath = ""

func _ready():
	pass

func saveRoom(roomName):
	# Check if there is a Room node
	if get_node("/root/Main").has_node("Room"):
		# Save node's in group "save" data to roomState dictionary
		# Data like a chest that was opened or item that has been collected
		roomState[roomName] = {}
		var nodesInGroup = get_tree().get_nodes_in_group("save")
		for node in nodesInGroup:
			node.isLoaded = false
			roomState[roomName][node.name] = node.call("save")
			# Send "save" call which should return a dictionary
			# Any var that you want to save
			# Example -
			# func
			# var toSave = {
			#		"name": name
			#		"pos_x": positon.x  - Vector2 is not supported by JSON
			#		"pos_y": positon.y
			#		"picked": picked
			#		"state": state
			#}

func loadRoomNoSave(roomName):
	# Check if there is a Room node
	if get_node("/root/Main").has_node("Room"):
		var room = get_tree().get_root().get_node("Main").get_node("Room")
		get_node("/root/Main").remove_child(room)
	# Load new room from roomPath as a child node Room in MainScene
	var roomNext = load("res://" + roomPath + roomName + ".tscn")
	#
	# You've been sent here after game crashed that mean
	# that something in your scene failed to load
	#
	var roomNextInstance = roomNext.instance()
	#
	#
	roomNextInstance.set_name("Room")
	get_node("/root/Main").add_child(roomNextInstance, true)
	roomPrevious = roomName
	# Load data from roomState
	# Node fill "loadData"
	var nodesInGroup = get_tree().get_nodes_in_group("save")
	if roomState.has(roomName) == true:
		for i in roomState[roomName].size():
			for node in nodesInGroup:
				var data = roomState[roomName].values()[i]
				if node.name == data.name and node.isLoaded == false:
					node.load(data)
					node.isLoaded = true

func loadRoom(roomName):
	self.saveRoom(roomPrevious)
	self.loadRoomNoSave(roomName)

