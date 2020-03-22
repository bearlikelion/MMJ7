extends "res://src/_personal/Taurol/StateMachine/state.gd"


func handle_input(event):
	if event.is_action_pressed("simulate_damage"):
		emit_signal("finished", "hurt")


func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input_direction.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input_direction


func update_look_direction(direction):
	if direction and owner.look_direction != direction:
		owner.look_direction = direction
	if not direction.x in [-1, 1]:
		return
	