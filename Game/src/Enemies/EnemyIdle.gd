extends "res://src/_personal/Taurol/StateMachine/state.gd"

func enter():
	pass

func exit():
	pass

func update(delta):
	owner.velocity = Vector2.ZERO
	if owner.player:
		emit_signal("finished", "chase")
