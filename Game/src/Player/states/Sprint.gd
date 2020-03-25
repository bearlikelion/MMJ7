extends "res://src/_personal/Taurol/Player/States/Move.gd"


func update(delta):
	if !Input.is_action_pressed("sprint"):
		emit_signal("finished","walk")
	var input_direction = get_input_direction()
	if not input_direction:
		if owner.motion==Vector2.ZERO:
			emit_signal("finished", "idle")
	move(input_direction,delta)
