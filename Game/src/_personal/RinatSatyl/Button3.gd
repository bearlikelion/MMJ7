extends CheckBox

export var RoomPath = ""

func _toggled(button_pressed):
	room.loadRoom(RoomPath)
